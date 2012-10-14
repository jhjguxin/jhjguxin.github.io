---
layout: post
title: "LVM (简体中文)"
date: 2012-06-01 10:55
comments: true
categories: ["linux", "ubuntu"]
tags: ["linux", "logical", "lvm", "volume"]
---
## LVM (简体中文)
<h2> 介绍</h2>
LVM 是一个应用于 Linux 内核的本地卷管理器 (Logical Volume Manager)。 使用 LVM 你可以抽象你的存储空间，并且可以有很容易更改的“虚拟分区”。LVM的基本模块如下：
<ul>
	<li><strong>Physical volume (PV)</strong>: 物理卷,例如一个硬盘,或一个Software RAID设备; 硬盘的一个分区 (或者甚至硬盘本身或者回环文件)，在它上面可以建立卷组。It has a special header and is divided into physical extents. Think of physical volumes as big building blocks which can be used to build your hard drive.</li>
	<li><strong>Volume group (VG)</strong>: 卷组,将一组物理卷收集为一个管理单元;Group of physical volumes that are used as storage volume (as one disk). They contain logical volumes. Think of volume groups as hard drives.</li>
	<li><strong>Logical volume(LV)</strong>: 逻辑卷,等同于传统分区,可看作便准的块设备,以容纳文件系统;A "virtual/logical partition" that resides in a volume group and is composed of physical extents. Think of logical volumes as normal partitions.</li>
	<li><strong>Physical extent (PE)</strong>: 物理块,划分物理卷的数据块;A small part of a disk (usually 4MB) that can be assigned to a logical Volume. Think of physical extents as parts of disks that can be allocated to any partition.</li>
</ul>
使用 LVM 你可以比正常的硬盘分区更容易的管理硬盘分区（逻辑卷）。例如，你可以：
<ul>
	<li>使用卷组(VG)，使众多硬盘空间看起来像一个大硬盘。</li>
	<li>使用逻辑卷（LV），可以创建跨越众多硬盘空间的分区。</li>
	<li>可以根据需要，对分区（LV）和硬盘空间（VG）进行创建、删除、调整大小等操作。(it doesn't depend on position of the logical volumes within volume groups as with normal partitions)</li>
	<li>Resize/create/delete partitions(LV) and disks(VG) <em>online</em> (filesystems on them still need to be resized, but some support online resizing)</li>
	<li><em>Name</em> your disks(VG) and partitions(LV) as you like</li>
	<li>Create small partitions(LV) and resize them "<em>dynamically</em>" as they get more filled (growing must be still done by hand, but you can do it online with some filesystems)</li>
	<li>...</li>
</ul>
示例:
<pre><strong>两块物理硬盘</strong>

  硬盘1 (/dev/sda):
     _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
    |分区1 50GB (Physical volume) |分区2 80GB (Physical volume)     |
    |/dev/sda1                   |/dev/sda2                       |
    |_ _ _ _ _ _ _ _ _ _ _ _ _ _ |_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ |

  硬盘2 (/dev/sdb):
     _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
    |分区1 120GB (Physical volume)                 |
    |/dev/sdb1                                    |
    | _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ __ _ _|</pre>
<pre><strong>LVM方式</strong>

  卷组VG1 (/dev/MyStorage/ = /dev/sda1 + /dev/sda2 + /dev/sdb1):
     _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _  
    |逻辑卷lv1 15GB         |逻辑卷lv2 35GB              |逻辑卷lv3 200GB               |
    |/dev/MyStorage/rootvol|/dev/MyStorage/usrvol     |/dev/MyStorage/homevol       |
    |_ _ _ _ _ _ _ _ _ _ _ |_ _ _ _ _ _ _ _ _ _ _ _ _ |_ _ _ _ _ _ _ _ _ _ _ _ _ _ _|</pre>
总而言之: With LVM you can use all your storage space as one big disk (volume group) and have more flexibility over your partitions (logical volumes).
<h2>Advantages</h2>
Here are some things you can do with LVM that you can't (or can't do easily) with just mdadm, MBR partitions, GPT partitions, parted/gparted and a file-level tool like rsync.
<ol>
	<li>Online/live partition resizing</li>
	<li>No need for an extended partition (not relevant for GPT)</li>
	<li>Resize partitions regardless of their order on disk (no need to ensure surrounding available space)</li>
	<li>Online/live migration of partitions being used by services without having to restart services</li>
</ol>
These can be very helpful in a server situation, desktop less so, but you must decide if the features are worth the abstraction.
<h2>安装</h2>
在做其他工作之前，我们需要加载合适的模块：
<pre># modprobe dm-mod</pre>
如果你已经安装好了操作系统，并只是想利用增加或尝试一个LVM分区，请跳到这 <a title="Lvm" href="https://wiki.archlinux.org/index.php/Lvm#Partition_disks">partition disks</a>.
<h3>在 LVM 上安装 Arch Linux</h3>
在开始安装arch之前（即输入：/arch/setup之前），先使用cfdisk等工具来规划分区。因为grub不能从LVM逻辑卷引导启动 （版本1.0时），所以需要先创建一个/boot引导区，100MB应该够了。另外的解决办法就是使用lilo或者高于1.95版本的grub。
<h3>创建 LVM 分区</h3>
接下来，要创建LVM将使用的分区。文件类型使用'Linux LVM'，所以使用分区id 0x8e (文件系统类型：8E)。在需要使用LVM的每块硬盘上，各创建一个LVM分区。 Your logical volumes will reside inside these partitions so size them accordingly. If you will use only LVM and no other external partitions, use all of free space on each disk.
<div><strong> 警告: </strong> /boot不能包含在LVM分区里，因为grub (version&lt;1.95)不能从LVM中引导grub。</div>
<div><strong> 小贴士: </strong>所有硬盘的所有LVM分区可以被设置成看起来就像一个大硬盘。</div>
<h3>创建物理卷（PV）</h3>
接下来，要加载使用lvm所需的相应模块:
<pre># modprobe dm-mod</pre>
用命令'fdisk -l'查看那个分区的文件系统类型是'Linux LVM'，然后在其上创建一个物理卷组pv（假设是/dev/sda2)，输入如下命令:
<pre># pvcreate /dev/sda2</pre>
Substitute /dev/sda2 with all your partitions to create physical volumes on all of them. This command creates a header on each partition so it can be used for LVM. 查看物理卷情况：
<pre># pvdisplay</pre>
<h3>创建卷组（VG）</h3>
创建完成物理卷之后，就是开始创建卷组了。 如果有两个以上的物理卷pv（比如下面例子，有两个/dev/sda2和/dev/sdb1），首先必须先在其中一个创建一个卷组vg，然后让该卷组vg 扩大到其他所有的物理卷pv（这里假设你只使用一个卷组vg来管理其他所有的物理卷pv。）:
<pre># vgcreate VolGroup00 /dev/sda2
# vgextend VolGroup00 /dev/sdb1</pre>
其中，“VolGroup00”名字换成你自己起的名字即可。接下来看看卷组情况：
<pre># vgdisplay</pre>
<div><strong> 注意: </strong>可以创建多于一个的卷组，但因此将让你的硬盘空间看起来不像一块硬盘。</div>
<h3>创建逻辑卷（LV）</h3>
创建完卷组vg之后，就可以开始创建逻辑卷了。输入下面命令：
<pre># lvcreate -L 10G VolGroup00 -n lvolhome</pre>
其中10G是大小，VolGroup00是卷组vg名称，lvolhome是逻辑卷lv名称，这些都可以根据你自己喜欢设定，以后可以使用/dev/mapper/Volgroup00-lvolhome 或者 /dev/VolGroup00/lvolhome来操作.

查看逻辑卷情况:
<pre># lvdisplay</pre>
<div><strong> 注意: </strong>You may need to load the <em>device-mapper</em> kernel module (<strong>modprobe dm-mod</strong>) for the above commands to succeed.</div>
<div><strong> 小贴士: </strong>一开始可以创建小一点的逻辑卷lv，然后留一部分未使用空间在卷组vg里，以后可以根据需要再扩展各个逻辑卷。</div>
<h3>建立文件系统与挂载逻辑卷</h3>
Your logical volumes should now be located in <strong>/dev/mapper/</strong> and <strong>/dev/YourVolumeGroupName</strong>. If you can't find them use the next commands to bring up the module for creating device nodes and to make volume groups availabile:
<pre># modprobe dm-mod
# vgscan
# vgchange -ay</pre>
Now you can create filesystems on logical volumes and mount them as normal partitions (if you are installing Arch linux, skip this step):
<pre># mkfs.ext3 /dev/mapper/VolGroup00-lvolhome
# mount /dev/mapper/VolGroup00-lvolhome /home</pre>
如果你正在安装Archlinux，到 <em>Prepare Hard Drive</em> 这一步时，转到第三项 <em>Set Filesystem Mountpoints</em> ，请 <em><strong>在进入安装前，阅读下面的 <a title="Arch LVM配置 (简体中文)" href="https://wiki.archlinux.org/index.php/Arch_LVM%E9%85%8D%E7%BD%AE_%28%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%29#.E9.87.8D.E8.A6.81">重要</a>部分 !</strong></em>
<h3>重要</h3>
有几点在使用/安装带有 LVM 的 Arch Linux 时你需要特别注意的地方。（括号里是相关的安装过程中的菜单）：
<h4>设置文件系统挂载点</h4>
<ul>
	<li>当选择挂载点时（除了/boot），千万不要选择实际存在的逻辑卷（比如：<code>/dev/sda2</code>），只需选择由lv创建的逻辑卷（比如: <code>/dev/mapper/Volgroup00-lvolhome</code>)。</li>
</ul>
<h4>配置系统</h4>
<ul>
	<li>确保在 <code>/etc/rc.conf</code> 中，把<code>USELVM="no"</code>修改成 <code>USELVM="yes"</code>。<code>rc.sysinit</code> 脚本处理 <code>USELVM</code> 变量时只会识别<code>yes</code> 或者 <code>YES</code>，不支持大小写混合。</li>
</ul>
<ul>
	<li>确保 <em>lvm2</em> 在 <code>/etc/mkinitcpio.conf</code> HOOKS 部分的 <em>filesystems</em> 前面，这样您的内核就可以在启动时找到 LVM 卷。</li>
	<li>If your root filesystem ( "/" ) is put onto a logical volume, make sure regenerate kernel image based on above modified <code>/etc/mkinitcpio.conf</code> by using below command so that bootloader can find your root during booting</li>
</ul>
<pre>     cd /boot 
     mkinitcpio -p linux</pre>
<ul>
	<li>确保为 root 使用了正确的卷。</li>
</ul>
<dl><dd>对于 GRUB，编辑<code>/boot/grub/menu.lst</code> ：</dd></dl>
<pre>     ...
     (0) Arch Linux
     title  Arch Linux
     root   (hd0,0)
     kernel /vmlinuz-linux <strong>root=/dev/mapper/VolGroup00-lvolroot</strong> resume=/dev/mapper/VolGroup00-lvolswap ro
     initrd /initramfs-linux.img
     ...</pre>
<dl><dd>For SYSLINUX, edit <code>/boot/syslinux/syslinux.cfg</code>:</dd></dl>
<pre>     ...
     # (0) Arch Linux
     LABEL arch
       MENU LABEL Arch Linux
       LINUX ../vmlinuz-linux
       APPEND <strong>root=/dev/mapper/VolGroup00-lvolroot</strong> ro
       INITRD ../initramfs-linux.img</pre>
<dl><dd>对于 LILO ，检查 <code>/etc/lilo.conf</code>:</dd></dl>
<pre>     ...
     image=/boot/vmlinuz-linux
       label=arch
       append="<strong>root=/dev/mapper/VolGroup00-lvolroot</strong> resume=/dev/mapper/VolGroup00-lvolswap ro"
       initrd=/boot/initramfs-linux.img
     ...</pre>
<h2>配置</h2>
<h3>扩大逻辑卷</h3>
To grow a logical volume you first need to grow the logical volume and then the filesystem to use the newly created free space. Let's say we have a logical volume of 15GB with ext3 on it and we want to grow it to 20G. We need to do the following steps:
<pre># lvextend -L 20G VolGroup00/lvolhome (or lvresize -L +5G VolGroup00/lvolhome)
# resize2fs /dev/VolGroup00/lvolhome</pre>
You may use lvresize insted of lvextend.

If you want to fill all the free space on a volume group use the next command:
<pre># lvextend -l +100%FREE VolGroup00/lvolhome</pre>
<div><strong> 警告: </strong>并非所有的文件系统都支持无损或在线扩大逻辑卷。</div>
<div><strong> 注意: </strong>If you do not resize your filesystem, you will still have a volume with the same size as before (volume will be bigger but partly unused).</div>
<h3>缩小逻辑卷</h3>
Because your filesystem is probably as big as the logical volume it resides on, you need to shrink the filesystem first and then shrink the logical volume. Depending on your filesystem, you may need to unmount it first. Let us say we have a logical volume of 15GB with ext3 on it and we want to shrink it to 10G. We need to do the following steps:
<pre># resize2fs /dev/VolGroup00/lvolhome 9G
# lvreduce -L 10G VolGroup00/lvolhome (or lvresize -L -5G VolGroup00/lvolhome)
# resize2fs /dev/VolGroup00/lvolhome</pre>
Here we shrunk the filesystem more than needed so that when we shrunk the logical volume we did not accidentally cut off the end of the filesystem. After that we normally grow the filesystem to fill all free space left on logical volume. You may use <code>lvresize</code> instead of <code>lvreduce</code>.
<div><strong> Warning: </strong>
<ul>
	<li>Do not reduce the filesystem size to less than the amount of space occupied by data or you risk data loss.</li>
	<li>Not all filesystems support shrinking without loss of data and/or shrinking online.</li>
</ul>
</div>
<div><strong> Note: </strong>It is better to reduce the filesystem to a smaller size than the logical volume, so that after resizing the logical volume, we do not accidentally cut off some data from the end of the filesystem.</div>
<h3>Remove logical volume</h3>
<div><strong> Warning: </strong>Before you remove a logical volume, make sure to move all data that you want to keep somewhere else, otherwise it will be lost!</div>
First, find out the name of the logical volume you want to remove. You can get a list of all logical volumes installed on the system with:
<pre># lvs</pre>
Next, look up the mountpoint for your chosen logical volume...:
<pre>$ df -h</pre>
... and unmount it:
<pre># umount /your_mountpoint</pre>
Finally, remove the logical volume:
<pre># lvremove /dev/yourVG/yourLV</pre>
Confirm by typing "y" and you are done.

Dont forget, to update /etc/fstab:
<pre># sudo nano /etc/fstab</pre>
You can verify the removal of your logical volume by typing "lvs" as root again (see first step of this section).
<h3>添加分区到卷组中</h3>
To add a partition to your volume group you must first make its type 'Linux LVM' (for example with <code>cfdisk</code>). Then you need to create a physical volume on it and extend the volume group over it:
<pre># pvcreate /dev/sdb1
# vgextend VolGroup00 /dev/sdb1</pre>
Now you have free space in your volume group that can be used by logical volumes in this group.
<div><strong> Tip: </strong>You can add partitions from any disks to volume groups.</div>
<h3>从卷组中移除卷</h3>
All of the data on that partition needs to be moved to another partition. Fortunately, LVM makes this easy:
<pre># pvmove /dev/sdb1</pre>
If you want to have the data on a specific physical volume, specify that as the second argument to <code>pvmove</code>:
<pre># pvmove /dev/sdb1 /dev/sdf1</pre>
Then the physical volume needs to be removed from the volume group:
<pre># vgreduce myVg /dev/sdb1</pre>
Or remove all empty physical volumes:
<pre># vgreduce --all vg0</pre>
And lastly, if you want to use the partition for something else, and want to avoid LVM thinking that the partition is a physical volume:
<pre># pvremove /dev/sdb1</pre>
<h3>快照功能</h3>
<h4>介绍</h4>
LVM可以给系统创建一个快照，由于使用了COW (copy-on-write) 策略，相比传统的备份更有效率。 The initial snapshot you take simply contains hard-links to the inodes of your actual data. So long as your data remains unchanged, the snapshot merely contains its inode pointers and not the data itself. Whenever you modify a file or directory that the snapshot points to, LVM automatically clones the data, the old copy referenced by the snapshot, and the new copy referenced by your active system. 这样的话，如果你只修改了不超过2G数据（包括原始的和快照的），你将可以只使用2G的空间，就能快照一个有35G的数据的系统。
<h4>配置</h4>
You create snapshot logical volumes just like normal ones.
<pre># lvcreate --size 100M --snapshot --name snap01 /dev/mapper/vg0-pv</pre>
With that volume, you may modify less than 100M of data, before the snapshot volume fills up.

Todo: scripts to automate snapshots of root before updates, to rollback... updating menu.lst to boot snapshots (separate article?)

snapshots are primarily used to provide a frozen copy of a filesystem to make backups; a backup taking two hours provides a more consistent image of the filesystem than directly backing up the partition.
<h2>常见问题</h2>
<h3>LVM 命令不起作用</h3>
try preceeding commands with <em>lvm</em> like this:
<pre># lvm pvdisplay</pre>
<h3>设定文件系统挂载点的页面不显示逻辑卷</h3>
If you are installing on a system where there is an existing volume group, you may find that even after doing "modprobe dm-mod" you don't see the list of logical volumes.

In this case, you may also need to do:
<pre># vgchange -ay &lt;volgroup&gt;</pre>
in order to activate the volume group and make the logical volumes available.
<h3>Receiving Input/Output Errors after plugging in a removable device with LVM partitions</h3>
Symptoms:
<pre>~$ sudo vgscan
 Reading all physical volumes.  This may take a while...
 /dev/backupdrive1/backup: read failed after 0 of 4096 at 319836585984: Input/output error
 /dev/backupdrive1/backup: read failed after 0 of 4096 at 319836643328: Input/output error
 /dev/backupdrive1/backup: read failed after 0 of 4096 at 0: Input/output error
 /dev/backupdrive1/backup: read failed after 0 of 4096 at 4096: Input/output error
 Found volume group "backupdrive1" using metadata type lvm2
 Found volume group "networkdrive" using metadata type lvm2</pre>
Cause:

<dl><dd>Removing an external LVM drive without deactivating the volume group(s) first. Before you disconnect, make sure to:</dd></dl>
<pre># vgchange -an &lt;volume group name&gt;</pre>
Fix: (assuming you already tried to activate the volume group with vgchange -ay &lt;vg&gt;, and are receiving the Input/output errors
<pre># vgchange -an &lt;volume group name&gt;</pre>
<dl><dd>Unplug the external drive and wait a few minutes</dd></dl>
<pre># vgscan
# vgchange -ay &lt;volume group name&gt;</pre>
<h2>技巧</h2>
<h2>更多资源</h2>
archwiki的其他关于LVM的文章：
<ul>
	<li><a title="Installing with Software RAID or LVM" href="https://wiki.archlinux.org/index.php/Installing_with_Software_RAID_or_LVM">Installing with software RAID or LVM</a></li>
	<li><a title="RAID Encryption LVM" href="https://wiki.archlinux.org/index.php/RAID_Encryption_LVM">RAID encryption LVM</a></li>
</ul>
外部资源：
<ul>
	<li><a href="http://en.wikipedia.org/wiki/Logical_Volume_Manager_%28Linux%29" rel="nofollow">LVM on wikipedia</a></li>
	<li><a href="http://tldp.org/HOWTO/LVM-HOWTO/" rel="nofollow">LVM HOWTO on tldp.org </a></li>
	<li><a href="http://www.gentoo.org/doc/en/lvm2.xml" rel="nofollow">Gentoo LVM2 installation at gentoo.org </a></li>
	<li><a href="http://en.gentoo-wiki.com/wiki/LVM" rel="nofollow">LVM at en.gentoo-wiki.com</a></li>
</ul>
