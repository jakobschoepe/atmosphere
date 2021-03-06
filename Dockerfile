FROM rocker/shiny:4.2.0

LABEL maintainer="Jakob Schöpe <contact@atmosphere-platform.org>"

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

RUN R -e 'install.packages(c("bsplus", "htmltools", "RSQLite", "shinymanager", "shinyjs", "shinythemes"), dependencies = TRUE)'
#Please add tinytex and rmarkdown to install.packages()
#RUN R -e 'tinytex::install_tinytex()'
#RUN R -e 'tinytex::tlmgr_install(c("caption", "csquotes", "fancyhdr", "multirow", "pdflscape", "eso-pic", "grfext", "oberdiek", "pdfpages", "fp", "ms", "pgf", "pgfplots", "setspace", "soul", "stix", "babel-english"))'

COPY shiny-server.sh /usr/bin/shiny-server.sh

RUN chmod -R 755 /usr/bin/shiny-server.sh

#RUN sudo chown -R shiny:shiny /srv/shiny-server

#USER shiny

EXPOSE 3838

CMD ["/usr/bin/shiny-server.sh"]
