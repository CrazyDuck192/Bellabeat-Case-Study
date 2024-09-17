FitBit fitness tracker data analysis
================
2024-09-15

## Introduction

This file contains analysis and visualizing of [FitBit Fitness Tracker
Data](https://www.kaggle.com/datasets/arashnic/fitbit) as a part of case
study from [Google Data Analytics Professional Certificate
program](https://www.coursera.org/professional-certificates/google-data-analytics).
The main purpose of this analysis is searching for any trends and
insights, creating meaningful visualizations to generate ideas for
improving business and user experience. Chapters of the file:

1.  [Introduction](#intro)
2.  [Setup](#setup)
3.  [Importing data](#import)
4.  [Data overview](#overview)
5.  [Analysis](#analysis)
6.  [Conclusions](#conclusions)

## Setup

First of all, we need to load all required libraries we will use to
analyze and visualize data.

``` r
library(tidyverse)
library(ggalt)
library(cowplot)
```

## Importing data

To start working with data we need to import all datasets we will use
for analysis (all datasets were created using SQL on step “Process” of
case study project). We won’t use data about weight and heart rate due
to small user samples of these datasets.

``` r
daily_activity_total <- read.csv('prepared_data/daily_activity_total.csv')

hourly_intensity_total <- read.csv('prepared_data/hourly_intensity_total.csv')

hourly_steps_total <- read.csv('prepared_data/hourly_steps_total.csv')

hourly_calories_total <- read.csv('prepared_data/hourly_calories_total.csv')

daily_sleep_total <- read.csv('prepared_data/daily_sleep_total.csv')

average_sleep_by_weekdays <- read.csv('prepared_data/average_sleep_by_weekdays.csv')

bad_sleep_total <- read.csv('prepared_data/bad_sleep_total.csv')
```

## Data overview

Before starting the analysis, let’s look at the datasets we have.

``` r
head(daily_activity_total, 10)
```

    ##            Id        ActivityDate TotalSteps TotalDistance TrackerDistance
    ## 1  1503960366 2016-03-25 00:00:00      11004          7.11            7.11
    ## 2  1503960366 2016-03-26 00:00:00      17609         11.55           11.55
    ## 3  1503960366 2016-03-27 00:00:00      12736          8.53            8.53
    ## 4  1503960366 2016-03-28 00:00:00      13231          8.93            8.93
    ## 5  1503960366 2016-03-29 00:00:00      12041          7.85            7.85
    ## 6  1503960366 2016-03-30 00:00:00      10970          7.16            7.16
    ## 7  1503960366 2016-03-31 00:00:00      12256          7.86            7.86
    ## 8  1503960366 2016-04-01 00:00:00      12262          7.87            7.87
    ## 9  1503960366 2016-04-02 00:00:00      11248          7.25            7.25
    ## 10 1503960366 2016-04-03 00:00:00      10016          6.37            6.37
    ##    LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance
    ## 1                         0               2.57                     0.46
    ## 2                         0               6.92                     0.73
    ## 3                         0               4.66                     0.16
    ## 4                         0               3.19                     0.79
    ## 5                         0               2.16                     1.09
    ## 6                         0               2.36                     0.51
    ## 7                         0               2.29                     0.49
    ## 8                         0               3.32                     0.83
    ## 9                         0               3.00                     0.45
    ## 10                        0               0.91                     1.28
    ##    LightActiveDistance SedentaryActiveDistance VeryActiveMinutes
    ## 1                 4.07                       0                33
    ## 2                 3.91                       0                89
    ## 3                 3.71                       0                56
    ## 4                 4.95                       0                39
    ## 5                 4.61                       0                28
    ## 6                 4.29                       0                30
    ## 7                 5.04                       0                33
    ## 8                 3.64                       0                47
    ## 9                 3.74                       0                40
    ## 10                4.18                       0                15
    ##    FairlyActiveMinutes LightlyActiveMinutes SedentaryMinutes Calories
    ## 1                   12                  205              804     1819
    ## 2                   17                  274              588     2154
    ## 3                    5                  268              605     1944
    ## 4                   20                  224             1080     1932
    ## 5                   28                  243              763     1886
    ## 6                   13                  223             1174     1820
    ## 7                   12                  239              820     1889
    ## 8                   21                  200              866     1868
    ## 9                   11                  244              636     1843
    ## 10                  30                  314              655     1850
    ##         period
    ## 1  march-april
    ## 2  march-april
    ## 3  march-april
    ## 4  march-april
    ## 5  march-april
    ## 6  march-april
    ## 7  march-april
    ## 8  march-april
    ## 9  march-april
    ## 10 march-april

``` r
head(hourly_intensity_total, 10)
```

    ##            Id        ActivityHour TotalIntensity AverageIntensity      period
    ## 1  1503960366 2016-03-12 00:00:00              0                0 march-april
    ## 2  1503960366 2016-03-12 01:00:00              0                0 march-april
    ## 3  1503960366 2016-03-12 02:00:00              0                0 march-april
    ## 4  1503960366 2016-03-12 03:00:00              0                0 march-april
    ## 5  1503960366 2016-03-12 04:00:00              0                0 march-april
    ## 6  1503960366 2016-03-12 05:00:00              0                0 march-april
    ## 7  1503960366 2016-03-12 06:00:00              0                0 march-april
    ## 8  1503960366 2016-03-12 07:00:00              0                0 march-april
    ## 9  1503960366 2016-03-12 08:00:00              0                0 march-april
    ## 10 1503960366 2016-03-12 09:00:00              1                0 march-april

``` r
head(hourly_steps_total, 10)
```

    ##            Id        ActivityHour StepTotal      period
    ## 1  1503960366 2016-03-12 00:00:00         0 march-april
    ## 2  1503960366 2016-03-12 01:00:00         0 march-april
    ## 3  1503960366 2016-03-12 02:00:00         0 march-april
    ## 4  1503960366 2016-03-12 03:00:00         0 march-april
    ## 5  1503960366 2016-03-12 04:00:00         0 march-april
    ## 6  1503960366 2016-03-12 05:00:00         0 march-april
    ## 7  1503960366 2016-03-12 06:00:00         0 march-april
    ## 8  1503960366 2016-03-12 07:00:00         0 march-april
    ## 9  1503960366 2016-03-12 08:00:00         0 march-april
    ## 10 1503960366 2016-03-12 09:00:00         8 march-april

``` r
head(hourly_calories_total, 10)
```

    ##            Id        ActivityHour Calories      period
    ## 1  1503960366 2016-03-12 00:00:00       48 march-april
    ## 2  1503960366 2016-03-12 01:00:00       48 march-april
    ## 3  1503960366 2016-03-12 02:00:00       48 march-april
    ## 4  1503960366 2016-03-12 03:00:00       48 march-april
    ## 5  1503960366 2016-03-12 04:00:00       48 march-april
    ## 6  1503960366 2016-03-12 05:00:00       48 march-april
    ## 7  1503960366 2016-03-12 06:00:00       48 march-april
    ## 8  1503960366 2016-03-12 07:00:00       48 march-april
    ## 9  1503960366 2016-03-12 08:00:00       48 march-april
    ## 10 1503960366 2016-03-12 09:00:00       49 march-april

``` r
head(daily_sleep_total, 10)
```

    ##            Id            SleepDay TotalSleepRecords TotalMinutesAsleep
    ## 1  1503960366 2016-03-13 00:00:00                 1                411
    ## 2  1503960366 2016-03-14 00:00:00                 1                354
    ## 3  1503960366 2016-03-15 00:00:00                 1                312
    ## 4  1503960366 2016-03-16 00:00:00                 2                333
    ## 5  1503960366 2016-03-17 00:00:00                 1                402
    ## 6  1503960366 2016-03-18 00:00:00                 1                379
    ## 7  1503960366 2016-03-19 00:00:00                 1                447
    ## 8  1503960366 2016-03-20 00:00:00                 1                469
    ## 9  1503960366 2016-03-21 00:00:00                 1                390
    ## 10 1503960366 2016-03-23 00:00:00                 1                281
    ##    TotalTimeInBed      period
    ## 1             426 march-april
    ## 2             386 march-april
    ## 3             335 march-april
    ## 4             366 march-april
    ## 5             437 march-april
    ## 6             411 march-april
    ## 7             468 march-april
    ## 8             476 march-april
    ## 9             427 march-april
    ## 10            297 march-april

``` r
head(average_sleep_by_weekdays, 10)
```

    ##     WeekDay AverageMinutesAsleep
    ## 1    Sunday             430.5736
    ## 2 Wednesday             426.0640
    ## 3  Saturday             423.7984
    ## 4    Monday             401.1513
    ## 5  Thursday             394.0813
    ## 6   Tuesday             387.3130
    ## 7    Friday             371.6364

``` r
head(bad_sleep_total, 10)
```

    ##            Id      period days
    ## 1  1503960366 march-april   19
    ## 2  1644430081 march-april    2
    ## 3  1844505072 march-april    3
    ## 4  1927972279 march-april   17
    ## 5  2022484408 march-april    1
    ## 6  2026352035 march-april    3
    ## 7  2347167796 march-april   13
    ## 8  3977333714 march-april   16
    ## 9  4020332650 march-april    9
    ## 10 4319703577 march-april    6

## Analysis

Now we can start our main part of analysis. We will research two aspects
of user data: user activity and user sleep.

Let’s start with exploring number of steps users walk everyday:

``` r
# create scatter plot with trend line for daily activity
daily_activity_total %>%
  ggplot(mapping = aes(x = TotalSteps, y = Calories, colour = period)) +
  geom_point(size = 1) + 
  geom_smooth(mapping = aes(linetype = ''), 
              se = FALSE, color = '#ff5959') +
  scale_color_manual(values = c('march-april' = '#57abff', 
                                'april-may' = '#304bff'), 
                     name = 'Periods') + 
  scale_linetype(name = "Trend line") + theme_bw() +
  labs(x = 'Steps',
       title = 'Relationship between number of steps and burned calories per day')
```

![](Analysis_files/figure-gfm/daily_steps_vs_calories-1.png)<!-- -->

We can see strong relationship between number of steps and number of
burned calories per day. This fact is pretty obvious but now we can see
it clearly. And what about this relationship during the day by hours?

``` r
# create line plot for steps
steps_plot <- hourly_steps_total %>%
  # group by hour of day and period
  group_by(time_hour = hour(ActivityHour), period) %>% 
  summarise(steps = mean(StepTotal)) %>%
  ggplot(mapping = 
           aes(x = time_hour, y = steps, group = period, 
              colour = period)) + 
  geom_point() + geom_xspline() +
  scale_color_manual(values = c('march-april' = '#57abff', 
                                'april-may' = '#304bff'), name = 'Periods') + 
  theme_bw() +
  labs(x = NULL, y = NULL,
       title = '',
       subtitle = 'Average number of steps during a day')


# create line plot for calories
calories_plot <- hourly_calories_total %>%
  # group by hour of day and period
  group_by(time_hour = hour(ActivityHour), period) %>%
  summarise(calories = mean(Calories)) %>%
  ggplot(mapping = aes(x = time_hour, y = calories, 
                       group = period, color = period)) + 
  geom_point() + geom_xspline() +
  scale_color_manual(values = c('march-april' = '#57abff', 
                                'april-may' = '#304bff'), name = 'Period') +
  theme_bw() +
  labs(x = NULL, y = NULL, 
       subtitle = 'Average number of burned calories during a day')


# display both charts together to compare them
plot_grid(steps_plot, calories_plot, nrow = 2)
```

![](Analysis_files/figure-gfm/hourly_steps_vs_calories-1.png)<!-- -->

And here we can see how similar these patterns are. So thanks to these
charts we made sure that walking is important to burn calories.

But what about real number of steps users walk everyday in average?

``` r
# group records by user Id to find average number of steps of every user
daily_activity_grouped <- daily_activity_total %>%
  group_by(Id) %>%
  summarise(average_steps = mean(TotalSteps))

# create bar plot for average number of steps of every user
daily_activity_grouped %>%
  ggplot(mapping = aes(x = reorder(as.character(Id), average_steps), 
                       y = average_steps, 
                       fill = average_steps > 6000)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  scale_fill_manual(values = c('FALSE' = '#ff5959', 'TRUE' = '#304bff'), 
                    name = 'Steps > 6000') +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) + 
  labs(x = NULL, y = 'Average number of steps',
       title = "Average number of steps each user walk per day")
```

![](Analysis_files/figure-gfm/average_steps_by_user-1.png)<!-- -->

``` r
# total number of users
length(daily_activity_grouped$average_steps)
```

    ## [1] 35

``` r
# number of users who walk less than 6000 steps per day in average
sum(daily_activity_grouped$average_steps < 6000)
```

    ## [1] 14

We can see that 14 of 35 users walk less than 6000 steps per day in
average (when it is recommended to walk at least 6000-8000 steps per
day).

Next, let’s review user’s activity at the whole. We will start with time
distributions of different activity types by days of week:

``` r
# create bar plot for every intensity type
daily_activity_total %>%
  group_by(week_day = wday(ActivityDate, label = TRUE, abbr = FALSE, 
                           week_start = 1, locale = 'English')) %>%
  # summarize by every type of intensity
  summarise(very_active = mean(VeryActiveMinutes),
            fairly_active = mean(FairlyActiveMinutes),
            lightly_active = mean(LightlyActiveMinutes)) %>%
  pivot_longer(cols = c('very_active', 'fairly_active', 'lightly_active'),
               names_to = 'intensity', values_to = 'minutes') %>%
  transform(
    # order intensity types from top to bottom within legend
    intensity = factor(intensity, 
                       levels = c('lightly_active',
                                  'fairly_active',
                                  'very_active'),
                       labels = c('Lightly active',
                                  'Fairly active',
                                  'Very active'))) %>%
  ggplot(mapping = aes(x = week_day, y = minutes, fill = intensity)) + 
  geom_bar(stat = 'identity', position = 'dodge') + 
  facet_grid(rows = vars(intensity), scales = 'free') + 
  scale_fill_manual(values = c('Lightly active' = '#52c5ff',
                               'Fairly active' = '#5294ff',
                               'Very active' = '#0f73ff'), name = 'Intensities') + 
  theme_bw() + 
  labs(x = NULL, y = 'Minutes',
       title = 'Time of different intensity types')
```

![](Analysis_files/figure-gfm/daily_intensity_types-1.png)<!-- -->

As we can see, average time of lightly active intensity per day is
around 180-190 minutes, average time of fairly active intensity is
around 13-14 minutes and time of very active time is around 19-20
minutes.

Let’s research relationships between intensity time and other
statistics:

``` r
# merge calories dataset and intensity dataset to
# create scatter plot with trend line
merge(x = hourly_calories_total, 
      y = hourly_intensity_total, 
      by.x = c('Id', 'ActivityHour', 'period'),
      by.y = c('Id', 'ActivityHour', 'period')) %>%
  ggplot(mapping = aes(x = Calories, y = TotalIntensity, colour = period)) +
  geom_point(size = 1) + 
  geom_smooth(mapping = aes(linetype = ''), se = FALSE, color = '#ff5959') +
  scale_color_manual(values = c('march-april' = '#57abff','april-may' = '#304bff'),
                     name = 'Periods') + 
  scale_linetype(name = "Trend line") + theme_bw() +
  labs(x = 'Calories', y = 'Intensity value',
       title = 'Relationship between burned calories and intensity value')
```

![](Analysis_files/figure-gfm/hourly_calories_vs_intensity-1.png)<!-- -->

Quite obvious that there is positive correlation between intensity time
and number of burned calories per hour.

``` r
# merge daily sleep dataset and hourly intensity dataset together
# to create scatter plot with trend line
merge(x = daily_sleep_total %>% transform(SleepDay = date(SleepDay)),
      y = hourly_intensity_total %>% 
        group_by(Id, activity_day = date(ActivityHour), period) %>%
        summarise(total_intensity = sum(TotalIntensity)),
      by.x = c('Id', 'SleepDay', 'period'),
      by.y = c('Id', 'activity_day', 'period')) %>%
  ggplot(mapping = aes(x = TotalMinutesAsleep, y = total_intensity, 
                       colour = period, group = 1)) +
  geom_point(size = 1) +
  geom_smooth(mapping = aes(linetype = ''), 
              se = FALSE, color = '#ff5959') +
  scale_color_manual(values = c('march-april' = '#57abff', 
                                'april-may' = '#304bff'), 
                     name = 'Periods') + 
  scale_linetype(name = "Trend line") + theme_bw() +
  labs(x = 'Minutes asleep',
       y = 'Intensity value',
       title = 'Relationship between sleep time and intensity value')
```

![](Analysis_files/figure-gfm/daily_sleep_vs_intensity-1.png)<!-- -->

Not so obvious: there is no correlation between intensity time and sleep
time.

``` r
# merge daily sleep dataset and daily activity dataset together 
# to create scatter plot with trend line
merge(x = daily_sleep_total,
      y = daily_activity_total,
      by.x = c('Id', 'SleepDay', 'period'),
      by.y = c('Id', 'ActivityDate', 'period')) %>%
  ggplot(mapping = aes(x = SedentaryMinutes, y = TotalMinutesAsleep, colour = period)) +
  geom_point(size = 1) +
  geom_smooth(mapping = aes(linetype = ''), 
              se = FALSE, color = '#ff5959') +
  scale_color_manual(values = c('march-april' = '#57abff', 
                                'april-may' = '#304bff'), 
                     name = 'Periods') + 
  scale_linetype(name = "Trend line") + theme_bw() +
  labs(x = 'Sedentary minutes',
       y = 'Minutes asleep',
       title = 'Relationship between sleep time and sedentary time, minutes')
```

![](Analysis_files/figure-gfm/daily_sleep_vs_sedentary_time-1.png)<!-- -->

And here we can see an interesting trend: there is negative correlation
between sleep time and sedentary time. Thus we can say that spending
less time sitting can improve user’s sleep.

But how users really sleep? Let’s answer this question:

``` r
# create bar plot for sleep time by days of week
average_sleep_by_weekdays %>% 
  transform(WeekDay = wday(1:7, label = TRUE, 
                           abbr = FALSE, locale = 'English')) %>%
  ggplot(mapping = aes(x = WeekDay, y = AverageMinutesAsleep)) +
  geom_bar(stat = 'identity', fill = '#4f85ff') + theme_bw() +
  labs(x = NULL, y = 'Minutes',
       title = 'Average sleep time, minutes')
```

![](Analysis_files/figure-gfm/weekdays_average_sleep_time-1.png)<!-- -->

In average users sleep longer on weekends and most of the week they
sleep less than 7 hours (which is minimum recommended sleep time).

``` r
# group records by user Id to find average sleep time of every user
daily_sleep_grouped <- daily_sleep_total %>%
  group_by(Id) %>%
  summarise(average_sleep_minutes = mean(TotalMinutesAsleep))

# create bar plot for average sleep time by user
daily_sleep_grouped %>%
  ggplot(mapping = aes(x = reorder(as.character(Id), average_sleep_minutes), 
                       y = average_sleep_minutes, 
                       fill = average_sleep_minutes >= 420)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  scale_fill_manual(values = c('FALSE' = '#ff5959', 'TRUE' = '#304bff'), 
                    name = 'Sleep time, minutes >= 420') + theme_bw() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) + 
  labs(x = NULL, y = 'Average sleep time',
       title = "Average sleep time of every user, minutes")
```

![](Analysis_files/figure-gfm/users_average_by_user-1.png)<!-- -->

``` r
# total number of users
length(daily_sleep_grouped$average_sleep_minutes)
```

    ## [1] 25

``` r
# number of users who sleep less than 7 hours per day in average
sum(daily_sleep_grouped$average_sleep_minutes < 420)
```

    ## [1] 17

Most of the users sleep less than 7 hours in average! Some of them even
sleep less than 3 hours! This requires special attention but we need
more data for deeper analysis.

``` r
# create bar plot for number of bad sleep days 
# (when user sleeps less than 7 hours) by days of week
merge(bad_sleep_total,
      bad_sleep_total %>% group_by(Id) %>% summarise(total_days = sum(days)), 
      by = c('Id')) %>%
  ggplot(mapping = aes(x = reorder(as.character(Id), -total_days), 
                       y = days, fill = period)) + 
  geom_bar(stat = 'identity') +
  scale_fill_manual(values = c('march-april' = '#59a7ff', 
                               'april-may' = '#4278ff'), 
                    labels = c('march-april', 'april-may'),
                    name = 'Periods') + theme_bw() + 
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  labs(x = NULL, y = 'Number of days', 
       title = "Number of days each user slept less than 7 hours")
```

![](Analysis_files/figure-gfm/bad_sleep-1.png)<!-- -->

And here we can see that some of the users most of the days slept less
than 7 hours per day. Lack of sleep can be serious problem so this
situation requires special attention.

## Conclusions

We have analysed data from user’s fitness trackers for two months and
have researched user’s physical activity and sleep. Based on gained
results and insights we can propose some ideas to improve product and
user experience of using smart devices:

- ability to set minimal number of steps user must walk during a day
  (every user can set his/her own minimal number of steps)
- give users an advise that decreasing sedentary time can improve their
  sleep
- give users an ability to research their sleep and physical activity
  statistics by themselves and give them advises for improving their
  health.
