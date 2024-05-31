#This is the code for my final project
#Griffin Lyons

#We read in our .csv file

nba2016.17.full <- read.csv("C:/Users/gakab/Documents/CS 555/2016-17_teamBoxScore.csv")

#We take every other game in order to remove the duplicates

nrow(nba2016.17.full)

#that's 2460 rows, so now we know how to make our new, shorter variable
#thanks to the sequence function

nba2016.17.orig <- nba2016.17.full[(seq(0,2460, by = 2)),]

#Now we can take a sample using the dplyr library

library(dplyr)

#Using dplyr's sample_n() function, we'll take a sample of size n = 120 from
#our halved NBA season variable (nba2016.17.orig)
#we will set the "replace" attribute to FALSE
#This way we won't risk getting the same game twice
#sample_n is being used because it's fast and convenient.
#We could also generate 120 random numbers in a range from 1 to 1230 (# of rows 
#in nba2016.17.orig)
#and then use those to index the variable for our sample

nba.samp <- sample_n(nba2016.17.orig, 120, replace = FALSE)

#We make a column of a variable for the First Quarter Point Difference

nba.samp$q1pd <- nba.samp[,38] - nba.samp[,94]

#We make a column of a variable for the First Half Point Difference

nba.samp$fhpd <- (nba.samp[,38]+nba.samp[,39]) - (nba.samp[,94]+nba.samp[,95])

#We make a column of a variable for the Total Point Difference
#This comes from the variables for the total points scored by each team, so that
#We do not have to manually add all of the columns for regulation time (the
#normal four quarters) and any overtime quarters

nba.samp$tpd <- nba.samp[,17] - nba.samp[,73]

#Now we make a dichotomized variable for wins and losses
nba.samp$winloss <- ifelse(nba.samp$teamRslt == "Win", 1, 0)

#Simple linear regression of 1st quarter point difference and total point
#difference

nba.lin.m1 <- lm(nba.samp$tpd ~ nba.samp$q1pd)

nba.lin.m1

#Visualization

hist(resid(nba.lin.m1))

plot(nba.samp$q1pd, nba.samp$tpd, xlim = c(-25,30), ylim = c(-30,30),
     xlab = "First Quarter Point Difference \n between Team and Opponent", 
     ylab = "Total Point Difference between \n Team and Opponent", 
     main = "Plot of First Quarter Point Differences \nAgainst Total Point Differences")
abline(nba.lin.m1, lty=3, col = "blue")

#Checking for outliers
plot(nba.lin.m1)

#after using the leverage plot to find outliers
outlier.1 <- lm(formula = nba.samp$tpd ~ nba.samp$q1pd,
                data = nba.samp[ -29, ])
abline(outlier.1, lty = 4, col = "red")

outlier.2 <- lm(formula = nba.samp$tpd ~ nba.samp$q1pd,
                data = nba.samp[ -11, ])
abline(outlier.2, lty = 4, col = "green")

outlier.3 <- lm(formula = nba.samp$tpd ~ nba.samp$q1pd,
                data = nba.samp[ -1, ])
abline(outlier.3, lty = 4, col = "yellow")

#Performing a summary
summary(nba.lin.m1)

#Anova
anova(nba.lin.m1)

#Multiple linear regression

nba.lin.m2 <- lm(nba.samp$tpd ~ 
                   nba.samp$q1pd+nba.samp$fhpd+nba.samp$teamFG.+nba.samp$teamTO)

#Finding F to perform the global test

qf(0.95,4,115)

#Using summary() to find the F statistic

summary(nba.lin.m2)

#Finding the t-statistic
qt(0.025, 115)

#Confidence interval:
confint(nba.lin.m2, level = 0.95)

#Simple logistic regression
nba.log.m1 <- glm(nba.samp$winloss ~ nba.samp$q1pd, family = binomial)
summary(nba.log.m1)

#Testing fit of model

library(pROC)
nba.samp$prob <- predict(nba.log.m1, type=c("response"))
nba.tg1 <- roc(nba.samp$winloss ~ nba.samp$prob)
print(nba.tg1)

#Multiple logistic regression

nba.log.m2 <- glm(nba.samp$winloss ~ nba.samp$q1pd + nba.samp$fhpd +
                    nba.samp$teamFG. + nba.samp$teamTO, family = binomial)
summary(nba.log.m2)

#Performing a significance test

library(aod)

wald.test(b=coef(nba.log.m2), Sigma = vcov(nba.log.m2), Terms = 2:5)

#Finding the area under the curve

nba.samp$prob2 <- predict(nba.log.m2, type=c("response"))
nba.tg2 <- roc(nba.samp$winloss ~ nba.samp$prob2)
print(nba.tg2)

#Visualizing the area under the curve

plot(1-nba.tg2$specificities, nba.tg2$sensitivities, type = "l",
     xlab = "1 - Specificity", ylab = "Sensitivity", 
     main = "ROC Curve for nba.tg2 model")
abline(a = 0, b = 1)
grid()




