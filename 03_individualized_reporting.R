# Using for loops for individualized reporting ----------------------------

# For individualized reporting, at least two things are needed: Rmarkdown template and script for looping
# The template is set up in 02_report_template
# rendering of the template can be done using th rmarkdown::render()

rmarkdown::render("02_report_template.Rmd") # renders report with default settings

# you can specify parameters using the params argument

rmarkdown::render("02_report_template.Rmd", params = list(Species = "virginica")) # report for the "virginica" species.
                                                                                  # Note that params have to a named list

# you can specify the name of the output file

rmarkdown::render("02_report_template.Rmd", params = list(Species = "virginica"),
                  output_file = "02_report_virginica.pdf")

# We could make report for each species manualy, but that's super inefficient:

rmarkdown::render("02_report_template.Rmd", params = list(Species = "virginica"),
                  output_file = "02_report_virginica.pdf")

rmarkdown::render("02_report_template.Rmd", params = list(Species = "setosa"),
                  output_file = "02_report_setosa.pdf")

rmarkdown::render("02_report_template.Rmd", params = list(Species = "versicolor"),
                  output_file = "02_report_versicolor.pdf")

# For loops are a better option:

species <- as.character(unique(iris$Species))

purrr::map(species,
           ~rmarkdown::render("02_report_template.Rmd", params = list(Species = .),
                              output_file = paste0("02_report_",. ,".pdf")))
