// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import { initFlatpickr } from "./plugins/flatpickr";
import { calctotal } from "./plugins/total";


window.addEventListener("turbo:load", function() {  initFlatpickr(); calctotal()});
