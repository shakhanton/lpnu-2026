#course та author

module "table_course" {
  source = "./modules/dynamodb"
  context = module.label.context
  name = "course"
}

module "table_author" {
  source = "./modules/dynamodb"
  context = module.label.context
  name = "author"
}
