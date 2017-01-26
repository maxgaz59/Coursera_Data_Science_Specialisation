library(corrplot)
library(Hmisc)
library(gridExtra)
library(dplyr)
library(ggplot2)
library(VGAM)
library(caret)


cars <- tbl_df(mtcars) 

# Split continuous and discrete variables
x <- cars %>% dplyr::select(mpg, disp, hp, drat, wt, qsec)
y <- cars %>% dplyr::select(cyl, vs, am, gear, carb) %>%
        mutate_all(funs(as.factor))
 

summary(cars)
describe(cars)

# Correlation plot to detect collinearity
corrplot(cor(cars), method="color", type="lower", addCoef.col = "black")

# Percentage of automatic/manual transmissions
percentage <- prop.table(table(cars$am)) *100
cbind(freq  = table(cars$am), percentage = percentage)

# Plot am vs mpg. 
p1 <- ggplot(cars, aes(am,mpg)) + geom_point()
print(p1)

# Boxplot mpg according to am
p2 <- ggplot(cars, aes(as.factor(am), mpg)) + geom_boxplot(aes(colour= as.factor(cyl)))
print(p2)

# Violin Plot
p3 <- ggplot(cars, aes(as.factor(am), mpg)) + geom_violin()
print(p3)



# Feature plots: group by am
obj1 <-featurePlot(x, y$am, plot="ellipse")
print(obj1)
obj2 <-featurePlot(x, y$am, plot="box")
print(obj2)
scales <- list(x  =list(relation = "free"), y=list(relation = "free"))
obj3 <-featurePlot(x, y$am, plot="density", scales= scales)
print(obj3)

# 
p11 <- ggplot(cars, aes(qsec, mpg)) + 
        geom_point(aes(colour= as.factor(am))) +
        geom_smooth(method = "lm")
p12 <- ggplot(cars, aes(wt, mpg)) +
        geom_point(aes(colour= as.factor(am))) + 
        geom_smooth(method = "lm")
p13 <- ggplot(cars, aes(qsec, wt)) + 
        geom_point(aes(colour= as.factor(am))) +
        geom_smooth(method = "lm")
grid.arrange(p11, p12, p13, nrow=3)
# g_legend<-function(a.gplot){
#         tmp <- ggplot_gtable(ggplot_build(a.gplot))
#         leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
#         legend <- tmp$grobs[[leg]]
#         return(legend)}
# legend <- g_legend(p13)
# lwidth <- sum(legend$width)
# ## using grid.arrange for convenience
# ## could also manually push viewports
# grid.arrange(arrangeGrob(p11 + theme(legend.position="none"),
#                          p12 + theme(legend.position="none"),
#                          p13 + theme(legend.position="none"),
#                          main ="Variable Name",
#                          left = "Value"),
#              legend, 
#              widths=unit.c(unit(1, "npc") - lwidth, lwidth), nrow=1)





# Feature plots: group by cyl
obj2 <-featurePlot(x, y$cyl, plot="ellipse")
print(obj2)

#fit.lm <- lm(mpg ~ . -cyl-vs-carb-gear-drat-disp-hp , data=cars)
 

fit.lm <- lm(mpg ~  . + wt:am  , data = mtcars)
# step-wise search using BIC
fit.lm <-step(fit.lm, k = log(nrow(cars)))


summary(fit.lm)
anova(fit.lm)
vif(fit.lm)
par(mfrow = c(2, 2)); plot(fit.lm)

e <- resid(fit.lm)
p5 <- ggplot(cars, aes(wt,e, colour= as.factor(am))) + geom_point()
p6<- ggplot(cars, aes(qsec,e, colour= as.factor(am))) + geom_point()
grid.arrange(p5, p6, nrow=2)
