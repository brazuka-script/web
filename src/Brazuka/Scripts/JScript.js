//Configuração de Canvas
//var canvas = document.getElementById("canvas");
//var ctx = canvas.getContext("2d");
//var grd = ctx.createLinearGradient(0, 70, 0, 0);
//grd.addColorStop(0.4, "#FFFFFF");
//grd.addColorStop(0.9, "#2E5679");
//ctx.fillStyle = grd;
////ctx.globalAlpha = 0.94;
//ctx.fillRect(0, 0, 900, 30);

function RememberPassword() {
    prompt("ATENÇÃO\nPor favor informe o email cadastro.", "Harry Potter");
}

function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
}

function validaCadastro() {
    var nome = document.getElementById("ctl00_cphConteudo_txtNomeModal");
    var email = document.getElementById("ctl00_cphConteudo_txtEmailModal");
    var senha = document.getElementById("ctl00_cphConteudo_txtSenhaModal");
    var senhaConfirma = document.getElementById("ctl00_cphConteudo_txtSenhaConfirmModal");
    var cpf = document.getElementById("ctl00_cphConteudo_txtCPFModal");
    var mgs = '';

    if (nome.value.indexOf("Nome Completo") >= 0){
        nome.value = "*Nome Completo";
        nome.style.color = 'red';
        mgs = "*Campo(s) Obrigatório(s)";
    } 
    if (email.value.indexOf("Email") >= 0){
        email.value = "*Email";
        email.style.color = 'red';
        mgs = "*Campo(s) Obrigatório(s)";
    } 
    if (senha.value.indexOf("Senha") >= 0){
        senha.value = "*Senha";
        senha.style.color = 'red';
        mgs = "*Campo(s) Obrigatório(s)";
    }
    if (senhaConfirma.value.indexOf("Confirme Senha") >= 0) {
        senhaConfirma.value = "*Confirme Senha";
        senhaConfirma.style.color = 'red';
        mgs = "*Campo(s) Obrigatório(s)";
    }
    if (mgs != '') {
        document.getElementById('mgsModal').innerText = mgs;
        return false;
    }
    return true;
    
//    if (inputValor.indexOf("@") < 1 || inputValor.indexOf(".") < 1) {
//        msg = "Email inválido.\n" + msg;
//        valido = false;
//    }
}

//Função para apresentação de através de JQUERY
//$(document).ready(function () {
//    $("#ctl00_cphConteudo_lblLinks").click(function () {
//        $("#container_links").show();
//        $("#container_links").animate({ height: 100, width:712 }, "slow");
//        $("#ctl00_cphConteudo_lblLinks").hide();
//        $("#ctl00_cphConteudo_lblLinksClose").show();
//    });
//    $("#ctl00_cphConteudo_lblLinksClose").click(function () {
//        $("#container_links").animate({ height: 0, width: 0 }, "slow");
//        $("#container_links").hide(100);
//        $("#ctl00_cphConteudo_lblLinksClose").hide();
//        $("#ctl00_cphConteudo_lblLinks").show();
//    });
//});


