// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import jQuery from "jquery"

window.jQuery = jQuery //

window.$ = jQuery