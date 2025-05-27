// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "@rails/ujs"
import Rails from "@rails/ujs"
import 'select2'
import 'select2/dist/css/select2.css'

Rails.start();

document.addEventListener("turbo:load", function () {
    $('.select2').select2({
        width: '100%',
        placeholder: "Выберите факультет(ы)",
        allowClear: true
    });
});
