<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <% if(request.getServletContext().getAttribute("sq") == null) { %>
    <head>
        <meta charset="UTF-8">
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="/pschat/bower_components/materialize/dist/css/materialize.min.css"  media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="/pschat/bower_components/izitoast/dist/css/iziToast.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>

    <body>
        <div class="container">
            <div class="center-align"><h3>Nenhuma pergunta secreta cadastrada para esta instância.</h3><h5>Bora criar uma?</h5></div>
            <div class="row">
                <form class="col s12" autocomplete="off" id="sqandsa">
                    <div class="row">
                        <div class="input-field col s12">
                            <i class="material-icons prefix">textsms</i>
                            <textarea id="sq" class="materialize-textarea flow-text validate" name="sq"></textarea>
                            <label for="sq" data-error="Pergunta inválida.">Pergunta secreta</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <i class="material-icons prefix">lock_outline</i>
                            <input id="sa" type="text" class="validate" name="sa">
                            <label for="sa" data-error="Resposta inválida.">Resposta secreta</label>
                            <label ></label>
                        </div>
                    </div>
                    <div class="center-align">
                        <button class="btn waves-effect waves-light" type="submit">Pronto
                            <i class="material-icons right">check</i>
                        </button>
                    </div>
                </form>
            </div>

        </div>
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="/pschat/bower_components/jquery/dist/jquery.min.js"></script>
        <script type="text/javascript" src="/pschat/bower_components/materialize/dist/js/materialize.min.js"></script>
        <script type="text/javascript" src="/pschat/bower_components/izitoast/dist/js/iziToast.min.js"></script>
        <script>
            $(function () {
                var f = $("form");
                f.find("textarea").focus();
                f.on("submit", function (e) {
                    e.preventDefault();
                    $(this).find("button").addClass("disabled");

                    $.ajax("/pschat/talk/private/secure/chat", {
                        method: "POST",
                        data: $(this).serialize(),
                        success: function (data) {
                            console.log(data);
                            var j = JSON.parse(data);
                            if (j.status == 1) {
                                iziToast.show({
                                    color: "green",
                                    message: "Pergunta cadastrada com sucesso. Aguarde!",
                                    timeout: 2000,
                                    position: "bottomCenter"
                                });
                                setTimeout(function () {
                                    window.location.href = "/pschat/talk/private/secure/chat";
                                }, 2000);
                            } else {

                            }
                        },
                        error: function (data) {
                            console.log(data);
                        },
                        complete: function () {
                            f.find("button").removeClass("disabled");
                        }
                    });

                });
            });
        </script>
    </body>
    <% } else {%>
    <script>
        window.location.href="/pschat/talk/private/secure/chat";
    </script>
    <% } %>
</html>
