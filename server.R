# There are 2 versions of the abtesting source code to make things more confusing. Uncomment just one.
#source('abtesting.R') # This is what is needed for deployment to shinyapps.io web site. UPDATE: DOES NOT WORK
#library('abtesting') # This is what is needed for using the package locally.

bettertextA = 'A is better than B.' 
bettertextB = 'B is better than A.' 
neitherbettertext = 'Cannot say that one is better than the other. The difference between the means of the two groups is indistinguishable from CHANCE. However, running more experimental trials still has the potential to surface a signal if one exists, as always.'

abtest.binary = function(a_s, a_f, b_s, b_f, conf.level=0.95, detail=FALSE) {       
    a_rate = a_s / (a_s + a_f)
    b_rate = b_s / (b_s + b_f)
    if (a_rate > b_rate) {
        x = c(a_s, b_s)
        n = c(a_s + a_f, b_s + b_f)
        bettertext = bettertextA
    } else {
        x = c(b_s, a_s)
        n = c(b_s + b_f, a_s + a_f)
        bettertext = bettertextB
    }        
    y = 0
    suppressWarnings(y <- prop.test(x=x, n=n, alternative='greater'))
    cutoffp = 1 - conf.level
    if (is.na(y$p.value)) {
        ret = neitherbettertext
    } else if (y$p.value <= cutoffp) {
        ret = bettertext
    } else {
        ret = neitherbettertext
    }
    if (detail) {
        ret = y
    }
    ret
}



shinyServer(
    function(input,output) {
	output$instructout <- renderPrint({'Lots of instructions go here.'})
	output$asout <- renderPrint(input$asin)
	output$afout <- renderPrint(input$afin)
	output$bsout <- renderPrint(input$bsin)
	output$bfout <- renderPrint(input$bfin)
        output$abtext <- renderPrint({if (input$asin>0) abtest.binary(input$asin, input$afin, input$bsin, input$bfin)})
	output$amean <- renderPrint(paste('Group A mean or average success rate:', if (input$asin>0) round(input$asin/(input$asin + input$afin), 3)))
	output$bmean <- renderPrint(paste('Group B mean or average success rate:', if (input$asin>0) round(input$bsin/(input$bsin + input$bfin), 3)))
    }
)
