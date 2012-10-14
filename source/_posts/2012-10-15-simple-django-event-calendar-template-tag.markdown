---
layout: post
title: "Simple Django event calendar template tag"
date: 2011-11-14 04:56
comments: true
categories: ["django"]
tags: ["calendar", "tagm", "templates"]
---
## Simple Django event calendar template tag
Simple Django event calendar template tag

<strong><a href="https://github.com/jhjguxin/blogserver">blogserver</a></strong> / <a href="https://github.com/jhjguxin/blogserver/tree/master/apps">apps</a> / <a href="https://github.com/jhjguxin/blogserver/tree/master/apps/blog">blog</a> / <a href="https://github.com/jhjguxin/blogserver/tree/master/apps/blog/templatetags">templatetags</a> / event_tags.py
<blockquote>
<div id="LC1">##### Here is the template tag code. It goes in a file named</div>
<div id="LC2"># "event_tags.py" in a subdirectory of your app called "templatetags".</div>
<div id="LC3">#####</div>
<div id="LC5">from calendar import HTMLCalendar</div>
<div id="LC6">from django import template</div>
<div id="LC7">from datetime import date</div>
<div id="LC8">from itertools import groupby</div>
<div id="LC9">import pdb</div>
<div id="LC10">from django.utils.html import conditional_escape as esc</div>
<div id="LC12">register = template.Library()</div>
<div id="LC14">def do_event_calendar(parser, token):</div>
<div id="LC15">    """</div>
<div id="LC16">    The template tag's syntax is {% event_calendar year month event_list %}</div>
<div id="LC17">    """</div>
<div id="LC19">    try:</div>
<div id="LC20">        tag_name, year, month, event_list = token.split_contents()</div>
<div id="LC21">    except ValueError:</div>
<div id="LC22">        raise template.TemplateSyntaxError, "%r tag requires three arguments" % token.contents.split()[0]</div>
<div id="LC23">    return EventCalendarNode(year, month, event_list)</div>
<div id="LC26">class EventCalendarNode(template.Node):</div>
<div id="LC27">    """</div>
<div id="LC28">    Process a particular node in the template. Fail silently.</div>
<div id="LC29">    """</div>
<div id="LC31">    def __init__(self, year, month, event_list):</div>
<div id="LC32">        try:</div>
<div id="LC33">            self.year = template.Variable(year)</div>
<div id="LC34">            self.month = template.Variable(month)</div>
<div id="LC35">            self.event_list = template.Variable(event_list)</div>
<div id="LC36">        except ValueError:</div>
<div id="LC37">            raise template.TemplateSyntaxError</div>
<div id="LC39">    def render(self, context):</div>
<div id="LC40">        try:</div>
<div id="LC41">            # Get the variables from the context so the method is thread-safe.</div>
<div id="LC42">            my_event_list = self.event_list.resolve(context)</div>
<div id="LC43">            my_year = self.year.resolve(context)</div>
<div id="LC44">            my_month = self.month.resolve(context)</div>
<div id="LC45">            cal = EventCalendar(my_event_list)</div>
<div id="LC46">            return cal.formatmonth(int(my_year), int(my_month))</div>
<div id="LC47">        except ValueError:</div>
<div id="LC48">            return        </div>
<div id="LC49">        except template.VariableDoesNotExist:</div>
<div id="LC50">            return</div>
<div id="LC53">class EventCalendar(HTMLCalendar):</div>
<div id="LC54">    """</div>
<div id="LC55">Overload Python's calendar.HTMLCalendar to add the appropriate events to</div>
<div id="LC56">    each day's table cell.</div>
<div id="LC57">    """</div>
<div id="LC59">    def __init__(self, events):</div>
<div id="LC60">        super(EventCalendar, self).__init__()</div>
<div id="LC61">        self.events = self.group_by_day(events)</div>
<div id="LC63">    def formatday(self, day, weekday):</div>
<div id="LC64">        if day != 0:</div>
<div id="LC65">            cssclass = self.cssclasses[weekday]</div>
<div id="LC66">            if date.today() == date(self.year, self.month, day):</div>
<div id="LC67">                cssclass += ' today'</div>
<div id="LC68">            if day in self.events:</div>
<div id="LC69">                cssclass += ' filled'</div>
<div id="LC70">                href="/%d/%d/%d/"%(self.year,self.month,day)</div>
<div id="LC71">                return self.day_cell(cssclass, '&lt;span&gt;&lt;a href=%s target="_blank"&gt;%d&lt;/a&gt;&lt;/span&gt;' % (href,day))</div>
<div id="LC72">            return self.day_cell(cssclass, '&lt;span&gt;%d&lt;/span&gt;' % (day))</div>
<div id="LC73">        return self.day_cell('noday', '&amp;nbsp;')</div>
<div id="LC75">    def formatmonth(self, year, month):</div>
<div id="LC76">        self.year, self.month = year, month</div>
<div id="LC77">        return super(EventCalendar, self).formatmonth(year, month)</div>
<div id="LC79">    def group_by_day(self, events):</div>
<div id="LC80">        field = lambda event: event.date_published.day</div>
<div id="LC81">        return dict(</div>
<div id="LC82">            [(day, list(items)) for day, items in groupby(events, field)]</div>
<div id="LC83">        )</div>
<div id="LC85">    def day_cell(self, cssclass, body):</div>
<div id="LC86">        return '&lt;td&gt;%s&lt;/td&gt;' % (cssclass, body)</div>
<div id="LC88"># Register the template tag so it is available to templates</div>
<div id="LC89">register.tag("event_calendar", do_event_calendar)</div></blockquote>
<div> <strong><a href="https://github.com/jhjguxin/blogserver">blogserver</a></strong> / views.py</div>
<blockquote>
<div>
<div id="LC1"># Create your views here.</div>
<div id="LC2">from django.shortcuts import render_to_response</div>
<div id="LC3">import pdb</div>
<div id="LC4">from datetime import *</div>
<div id="LC5">from calendar import monthrange</div>
<div id="LC6">from blogserver.apps.blog.models import Post</div>
<div id="LC7">from django.template import RequestContext</div>
<div id="LC8">from django.utils.html import conditional_escape as esc</div>
<div id="LC9">from django.utils.safestring import mark_safe</div>
<div id="LC10">from itertools import groupby</div>
<div id="LC11">from calendar import HTMLCalendar, monthrange</div>
<div id="LC12">##### Here's code for the view to look up the event objects for to put in</div>
<div id="LC13"># the context for the template. It goes in your app's views.py file (or</div>
<div id="LC14"># wherever you put your views).</div>
<div id="LC15">#####</div>
<div id="LC17">def named_month(month_number):</div>
<div id="LC18">    """</div>
<div id="LC19">    Return the name of the month, given the number.</div>
<div id="LC20">    """</div>
<div id="LC21">    return date(1900, month_number, 1).strftime("%B")</div>
<div id="LC23">def this_month(request):</div>
<div id="LC24">    """</div>
<div id="LC25">    Show calendar of events this month.</div>
<div id="LC26">    """</div>
<div id="LC27">    today = datetime.now()</div>
<div id="LC28">    return calendar(request, today.year, today.month)</div>
<div id="LC31">def calendar(request, year, month, series_id=None):</div>
<div id="LC32">    """</div>
<div id="LC33">    Show calendar of events for a given month of a given year.</div>
<div id="LC34">    ``series_id``</div>
<div id="LC35">    The event series to show. None shows all event series.</div>
<div id="LC37">    """</div>
<div id="LC39">    my_year = int(year)</div>
<div id="LC40">    my_month = int(month)</div>
<div id="LC41">    my_calendar_from_month = datetime(my_year, my_month, 1)</div>
<div id="LC42">    my_calendar_to_month = datetime(my_year, my_month, monthrange(my_year, my_month)[1])</div>
<div id="LC44">    my_events = Post.objects.filter(date_published__year=my_year, date_published__month=my_month)</div>
<div id="LC45">    if series_id:</div>
<div id="LC46">        my_events = my_events.filter(series=series_id)</div>
<div id="LC48">    # Calculate values for the calendar controls. 1-indexed (Jan = 1)</div>
<div id="LC49">    my_previous_year = my_year</div>
<div id="LC50">    my_previous_month = my_month - 1</div>
<div id="LC51">    if my_previous_month == 0:</div>
<div id="LC52">        my_previous_year = my_year - 1</div>
<div id="LC53">        my_previous_month = 12</div>
<div id="LC54">    my_next_year = my_year</div>
<div id="LC55">    my_next_month = my_month + 1</div>
<div id="LC56">    if my_next_month == 13:</div>
<div id="LC57">        my_next_year = my_year + 1</div>
<div id="LC58">        my_next_month = 1</div>
<div id="LC59">    my_year_after_this = my_year + 1</div>
<div id="LC60">    my_year_before_this = my_year - 1</div>
<div id="LC61">    #pdb.set_trace()</div>
<div id="LC62">    return render_to_response("blog/calendar.html", { 'events_list': my_events,</div>
<div id="LC63">                                                        'month': my_month,</div>
<div id="LC64">                                                        'month_name': named_month(my_month),</div>
<div id="LC65">                                                        'year': my_year,</div>
<div id="LC66">                                                        'previous_month': my_previous_month,</div>
<div id="LC67">                                                        'previous_month_name': named_month(my_previous_month),</div>
<div id="LC68">                                                        'previous_year': my_previous_year,</div>
<div id="LC69">                                                        'next_month': my_next_month,</div>
<div id="LC70">                                                        'next_month_name': named_month(my_next_month),</div>
<div id="LC71">                                                        'next_year': my_next_year,</div>
<div id="LC72">                                                        'year_before_this': my_year_before_this,</div>
<div id="LC73">                                                        'year_after_this': my_year_after_this,</div>
<div id="LC74">    }, context_instance=RequestContext(request))</div>
<div id="LC75">def post_calendar(request):</div>
<div id="LC76">  #pdb.set_trace()</div>
<div id="LC77">#  return render_to_response("base.html",)</div>
<div id="LC78">  lToday = datetime.now()</div>
<div id="LC79">  return calendar(request, lToday.year, lToday.month)</div>
</div></blockquote>
<div> <strong><a href="https://github.com/jhjguxin/blogserver">blogserver</a></strong> / <a href="https://github.com/jhjguxin/blogserver/tree/master/templates">templates</a> / <a href="https://github.com/jhjguxin/blogserver/tree/master/templates/blog">blog</a> / calendar.html</div>
<blockquote>
<div>
<div id="LC1">&lt;style type="text/css"&gt;</div>
<div id="LC2">/* Calendar */</div>
<div id="LC4">#calendar table {</div>
<div id="LC5">    width: 100%;</div>
<div id="LC6">}</div>
<div id="LC8">#calendar table tr th {</div>
<div id="LC9">    text-align: center;</div>
<div id="LC10">    font-size: 16px;</div>
<div id="LC11">    background-color: #316497;</div>
<div id="LC12">    color: #99ccff;</div>
<div id="LC13">}</div>
<div id="LC15">#calendar table tr td {</div>
<div id="LC16">    width: 10%;</div>
<div id="LC17">    border: 1px solid #555;</div>
<div id="LC18">    vertical-align: top;</div>
<div id="LC19">    height: 20px;</div>
<div id="LC20">    padding: 2px;</div>
<div id="LC21">}</div>
<div id="LC23">#calendar td.noday {</div>
<div id="LC24">    </div>
<div id="LC25">}</div>
<div id="LC27">#calendar td.filled {</div>
<div id="LC28">    background-color: #99ccff;</div>
<div id="LC29">}</div>
<div id="LC31">#calendar td.today {</div>
<div id="LC32">    border: 4px solid #316497;</div>
<div id="LC33">}</div>
<div id="LC35">#calendar .dayNumber {</div>
<div id="LC36">    font-size: 16px !important;</div>
<div id="LC37">    font-weight: bold;</div>
<div id="LC38">}</div>
<div id="LC40">#calendar a {</div>
<div id="LC41">    font-size: 10px;</div>
<div id="LC42">}</div>
<div id="LC44">}</div>
<div id="LC45">&lt;/style&gt;</div>
<div id="LC46">{% load event_tags %}</div>
<div id="LC48">&lt;div id="calendar"&gt;</div>
<div id="LC49">{% event_calendar year month events_list %}</div>
<div id="LC50">&lt;/div&gt;</div>
</div></blockquote>
<div>
<div>at end do not forget to setting your url files</div>
</div>
<div> </div>
<div>And I think the better way is bulit the calendar in css or js files and get event from the server</div>
