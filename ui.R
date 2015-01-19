library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("AB Test Outcome Analyzer"),    
    sidebarPanel(
        h3('Enter the outcome of your experiment.'),
        numericInput('asin', 'Number of Group A successes:', 0, min=0, max=9999),
        numericInput('afin', 'Group A failures:', 0, min=0, max=9999),
        numericInput('bsin', 'Group B successes:', 0, min=0, max=9999),
        numericInput('bfin', 'Group B failures:', 0, min=0, max=9999),
	submitButton('Analyze')
    ),
    mainPanel(
        h3('Analysis'),
	helpText('INSTRUCTIONS: This application evaluates the results from an experiment you already ran, of an A group and a B group that were used in an AB test. This application helps inform you if one way of doing things (A) can generally be expected to give better results than the other way (B), in future experiments. The experimental results must be binary outcomes only, such as success or failure, 1 or 0, yes or no. You must supply four parameters: First is an integer for number of successes in the A group. Second is an integer for number of failures in the A group. Third is an integer for number of successes in the B group. Fourth is an integer for number of failures in the B group. This function runs a hypothesis test on the binary outcome data of the experimental results of an A group and a B group.  The hypothesis test evaluates whether the means of the two groups are equal or is one mean higher than the other mean, other than from chance. The experimental outcomes used with this function need to be binary, that is either success or failure in the experimental trials. Different numbers of trials in groups A and B is perfectly acceptable. The signal in the data, if one exists, tends to be more reliably detectable and separable from the noise when there is a larger number of trials. Descriptive text is the output of the function, such as A is better than B.'),
	h4('You entered'),
	textOutput('asout'),
	textOutput('afout'),
	textOutput('bsout'),
	textOutput('bfout'),
	h4('Which when carefully analyzed, indicates that'),
	verbatimTextOutput('amean'),
	verbatimTextOutput('bmean'),
        h4(verbatimTextOutput('abtext'))
    )
))
