provider "google" {
    credentials = file("~/.config/gcloud/application_default_credentials.json")
    project = "cloud-native-night"
    region = "europe-west3"
}
