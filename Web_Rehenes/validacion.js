
function validarFormulario() {
    var nombre = document.getElementById("name").value;
    var apellido = document.getElementById("lastname").value;
    var codigo = document.getElementById("code").value;
    var telefono = document.getElementById("telephone").value;
    var email = document.getElementById("email").value;
    var mensaje = document.getElementById("message").value;
  
    if (nombre.trim() === "" || apellido.trim() === "" || codigo.trim() === "" || telefono.trim() === "" || email.trim() === "" || mensaje.trim() === "") {
      alert("Por favor, completa todos los campos obligatorios.");
      return false; 
     }
    }
