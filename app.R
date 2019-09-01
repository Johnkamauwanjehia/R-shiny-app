library(shiny)

#user interface
ui <-fluidPage(

  sidebarLayout(

    sidebarPanel(

      selectInput(inputId = "dataset",
                  label="choose your dataset",
                  choices = c("rock","pressure", "cars")),

      numericInput(inputId = "obs",
                   label = "number of observations",
                   value = 10)
    ),
    mainPanel(
      verbatimTextOutput("summary"),
      tableOutput("view")
    )
  )

)
#server logic
server<-function(input,output){

  datasetInput<-reactive({
    switch (input$dataset,
            "rock"=rock,
            "pressure"=pressure,
            "cars"=cars)

  })
  output$summary <-renderPrint({
    dataset<-datasetInput()
    summary(dataset)
  })
  output$view<-renderTable({
    head(datasetInput(),n=input$obs)})


}
shinyApp(ui,server)
