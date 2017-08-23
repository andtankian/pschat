<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String sq = (String) request.getServletContext().getAttribute("sq");%>
<% String sa = (String) request.getSession().getAttribute("sa");%>
<!DOCTYPE html>
<html>
    <% if(sq != null && sa == null) { %>
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
            <div class="center-align">
                <h4>Se liga nessa pergunta e responde com sapiência</h4>
                <h2 class="teal-text"><%= sq%> ?</h2>
            </div>
            <form class="col s12" autocomplete="off" id="sqandsa">
                <div class="row">

                    <div class="input-field col s12">
                        <i class="material-icons prefix">lock_outline</i>
                        <input id="sa" type="text" class="validate" name="sa">
                        <label for="sa" data-error="Resposta inválida.">Resposta secreta</label>
                        <label ></label>
                    </div>
                </div>
                <div class="center-align">
                    <button class="btn waves-effect waves-light" type="submit">Responder
                        <i class="material-icons right">check</i>
                    </button>
                </div>
            </form>
        </div>
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="/pschat/bower_components/jquery/dist/jquery.min.js"></script>
        <script type="text/javascript" src="/pschat/bower_components/materialize/dist/js/materialize.min.js"></script>
        <script type="text/javascript" src="/pschat/bower_components/izitoast/dist/js/iziToast.min.js"></script>
        <script>
            $(function () {
                var f = $("form");
                f.on("submit", function (e) {
                    e.preventDefault();
                    $.ajax("/pschat/wannaanswer", {
                        method: "POST",
                        data: $(this).serialize(),
                        success: function (data) {
                            var j = JSON.parse(data);
                            if (j.status == 1) {
                                iziToast.show({
                                    color: "green",
                                    timeout: 2000,
                                    message: "AEEEW, bora conversar!",
                                    position: "bottomCenter"
                                });
                                
                                setTimeout(function(){
                                    window.location.href = "/pschat/talk/private/secure/chat";
                                }, 2000);
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
