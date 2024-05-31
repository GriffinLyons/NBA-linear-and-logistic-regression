# NBA-linear-and-logistic-regression
This was my final project for my class "Data Analysis and Visualization" at Boston University, MET CS 555 in August 2022.

I performed an analysis of box score data from the NBA's 2016-2017 season, taken from this source: https://www.kaggle.com/datasets/pablote/nba-enhanced-stats.

Using linear regression and logistic regression, both simple and multiple, I explored whether traditional variables like percentage of field goals made (how many shots at the basket by a team successfully go in) or user-defined variables like the point difference between the home and visiting teams at the end of the first quarter had any predictive power as to whether the game would be a win or a loss for the home team.

The subject was relevant to me because I am interested in both basketball and sports analytics; I am a fan of the Boston Celtics and have (since this project) enjoyed analytical texts like Dean Oliver's seminal 'Basketball On Paper'.

I performed my work in R. I used the library dplyr for sampling, the library PROC for testing the fit of a logistic regression, and the library aod to test the significance of logistic regression.

I performed simple linear regression and multiple linear regression on the game-total point difference as the outcome variable/response variable (a positive point difference being a proxy for winning).
I also performed simple logistic regression and multiple logistic regression on the win/loss dichotomous variable as the outcome/response variable. First quarter point difference were the explanatory variable in both cases.

I examined the significance of my model results with methods including confidence intervals, the F-statistic, and the t-test. My R code and full report are included in this repository.

In conclusion, whether using linear or logistic regression, simple or multiple, I ultimately found that there is a weak or not significant relationship between first quarter point difference and total point difference/binary game outcome. Variables such as field goal percentage or the point difference after the first two quarters of the game have a stronger relationship to the outcome.

I completed this project almost two years ago, close to the start of my master's degree program; I have learned much about data analytics, data science, and basketball since. It illuminated the difficulty of wholly or even significantly explaining complex phenomena like basketball games through single variables, even ones meant to distill other variables.
