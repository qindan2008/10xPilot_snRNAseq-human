library('rsconnect')
load(here::here("shiny_apps", ".deploy_info.Rdata"))
rsconnect::setAccountInfo(name=deploy_info$name, token=deploy_info$token,
    secret=deploy_info$secret)
options(repos = BiocManager::repositories())
rsconnect::deployApp(appFiles = c('app.R', "sce_{{regionlower}}_small.rds", "cell_colors_{{regionlower}}.rds"),
    appName = 'tran2021_{{region}}', account = 'libd', server = 'shinyapps.io')
