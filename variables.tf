variable "prefix_name" {
    type = string
    default = "baptiste"
}

variable "environnement" {
    type = string
    description = "a ajouter entre le prefix et le type de ressource"
  
}
variable "vnet" {
    type = string
    description = "Nécessaire de le mettre en  pour 10.0.0.0/21"
}

variable "location" {
    type = string
    default = "West Europe"
}

variable "tag" {
    type = map(string)
}