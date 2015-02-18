# This app will illustrate random sampling. The user can choose a mean and 
# standard deviation for the population distribution, and the app will draw
# the probability density function for the population.
#
# The user can then choose what size sample to draw from the population, and 
# the app will plot the histogram of this sample.

library(shiny)
shinyUI(
  tabsetPanel(
    tabPanel("Documentation",
             h4("Sampling Distribution Demonstration"),
             p("This application demonstrates the concept of sampling distributions."),
             p("Under 'Configure the population', the user is able to set the mean and
               standard deviation of a hypothetical normally-distributed random variable.
               The probability density of this distribution is plotted."),
             p("The 'Redraw axes' button allows the user to re-center the population plot if desired."),
             p("Under 'Draw 1000 samples,' the user is able to choose a sample size and
              draw 1000 samples of that size from the population. A histogram of the means of all 1000
              samples is plotted. It can be demonstrated that larger sample sizes produce tighter distributions
              of the sample means."),
             HTML("The standard deviation of these sample means (SE(x&#772;)) is calculated and
              compared to the value predicted by the Central Limit Theorem, the standard deviation
              of the population divided by the square root of the sample size (&sigma;/&radic;n).")),

    tabPanel("Application",
             pageWithSidebar(
               headerPanel('Sampling Distributions'),
               
               sidebarPanel(
                 #have user enter a mean and standard deviation for the population distribution
                 h5("Configure the population"),
                 textInput('popmu',label='Population mean:',value='0'),
                 textInput('popsig',label='Population standard deviation:',value='1'),
                 br(),
                 
                 #button to redraw axes
                 actionButton('axisbutton',"Redraw Axes"),
                 br(),
                 br(),
                 h5("Draw 1000 samples"),
                 textInput('ss',label="Sample size:",value=30),
                 br(),
                 actionButton('samplebutton',"Draw Samples")
               ),
               mainPanel(
                 plotOutput('myDist'),
                 plotOutput('sampleMeans')
               )
             )
    )
  )
)
