FROM rocker/shiny:4.2

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev
    
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean 
    
COPY /R ./app

RUN R -e 'install.packages(c("bsplus", "htmltools", "RSQLite", "shinymanager", "shinyjs", "shinythemes", "tinytex", "rmarkdown"), dependencies = TRUE)'
RUN R -e 'tinytex::install_tinytex()'
RUN R -e 'tinytex::tlmgr_install(c("caption", "csquotes", "fancyhdr", "multirow", "pdflscape", "eso-pic", "grfext", "oberdiek", "pdfpages", "fp", "ms", "pgf", "pgfplots", "setspace", "soul", "stix", "babel-english"))'

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
