library(tidyr)
library(dplyr)
library(ggplot2)

set.seed(1214435)

lambda <- 0.2  #rate
n <- 40
m <- 1000
mu_theo <- 1/lambda
sigma_theo <- 1/lambda

# x <- matrix(rexp(n*m, lambda), n,m)
# 
# mu_emp <- apply(x, 2, mean)
# var_emp <- apply(x, 2, var)

# 
# x <- tbl_df(matrix(rexp(n*m, lambda), n,m))
# 
# mu_emp <- x %>% summarise_each(funs(mean)) %>% gather(var, mu, 1:ncol(x))  
# var_emp <- x %>% summarise_each(funs(var))%>% gather(var, sigma, 1:ncol(x))  
mu_emp  <- NULL
var_emp <- NULL
for (i in 1 : m){
        x   <- rexp(n, lambda)
        mu_emp <- c(mu_emp, mean(x))
        var_emp <- c(var_emp, var(x))
}

mu <- mean(mu_emp)
mean_legend <- paste("Empirical mean = ", as.character(signif(mu,4)))


print(summary(mu_emp))
print(mu_theo)

 

print(summary(var_emp))
print(sigma_theo^2)


plot1 <- ggplot() + 
        geom_vline(aes(xintercept= mu_theo,   color= mean_legend), linetype="dashed", size=1) +
        stat_function(fun = dexp, aes(colour = 'Exp density'), args = list(rate= lambda))+
        geom_histogram(aes(rexp(m, lambda), y = ..density..), col="black", fill= NA, alpha = 1 ,bins = 20) +
        labs(title="Empirical distribution from Exp(0.2)") +
        labs(x="Mean", y="Frequency")+
        scale_color_manual(name = "Statistics", values = c("blue", "red"))
        
        
print(plot1)        

plot2 <- ggplot() + 
        geom_vline(aes(xintercept= mean(mu),   color= mean_legend), linetype="dashed", size=1) +
        stat_function(fun = dnorm, aes(colour = 'Normal density'), args = list(mean = mu_theo, sd = sigma_theo/sqrt(n)))+
        geom_histogram(aes(mu_emp, y= ..density..), col="black", fill= NA, alpha = 1 ,bins = 20) +
        labs(title="Empirical distribution of means from Exp(0.2)") +
        labs(x="Mean", y="Frequency")+
        scale_color_manual(name = "Statistics", values = c("blue", "red"))
        

print(plot2)


TG_df <- group_by(ToothGrowth, dose= factor(dose), supp) %>% arrange(dose, supp, len)



plot3 <- ggplot(TG_df, aes(dose, len))+
        geom_boxplot()+
        facet_grid(.~supp)

print(plot3)

# plot4 <- ggplot(TG_df, aes(supp, len))+
#         geom_boxplot()+
#         facet_grid(.~dose)
# 
# print(plot4)

data <- TG_df %>% group_by(dose) %>% 
        summarise(mean = mean(len), sigma= sd(len), n=n(), CI95inf = mean - qt(0.975, n-1)*sigma/sqrt(n), CI95sup = mean + qt(0.975, n-1)*sigma/sqrt(n))


data$mean[2] -data$mean[1] +c(-1,1)*qt(0.975, 2*data$n[1]-2)*sqrt(data$sigma[2]^2 +data$sigma[1]^2)/sqrt(data$n[1])
data$mean[3] -data$mean[2] +c(-1,1)*qt(0.975, 2*data$n[1]-2)*sqrt(data$sigma[3]^2 +data$sigma[2]^2)/sqrt(data$n[1])

exEvent <-(data$mean[2] -data$mean[1] -9)/sqrt(data$sigma[2]^2 +data$sigma[1]^2)*sqrt(data$n[1])
qt(0.05, lower.tail =FALSE, df = 38)
pt(exEvent, lower.tail =FALSE, df = 38)


pt(exEvent, lower.tail =FALSE, df = 38) + pt(-exEvent, lower.tail = TRUE, df = 38)


t.test(TG_df$len[1:20], TG_df$len[21:40],  mu=0, paired= FALSE, conf.level=0.95, var.equal= TRUE)
t.test(TG_df$len[41:60], TG_df$len[21:40], mu=7, paired= FALSE, conf.level=0.95)

##Two hypothesis tests with null hypothesis either
## H_0: same mean and same variance 
## H_0: same mean and different variance 