<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="/pschat/bower_components/materialize/dist/css/materialize.min.css"  media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="/pschat/bower_components/izitoast/dist/css/iziToast.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <style>
            .card-chat {
                margin: 0 auto !important;
                width: 100vw;
                height: 100vh !important;
            }
            .chatters {
                margin: 0px !important;
                border-right: 0.5px solid rgba(0, 0, 0, 0.1);
                overflow-y: auto;
                height: 60vh;
            }

            .chat-content {
                margin-bottom: 0px !important;
                height: 60vh !important;
            }

            .custom-row {
                margin: 0px !important;
            }

            .send-button {
                top: 40px;
            }
        </style>
    </head>
    <body>
        <div class="pschat-container">                
            <div class="card card-chat darken-1">
                <div class="card-content blue-grey white-text">
                    <span class="card-title">PSChat</span>
                </div>
                <div class="chat-content row">
                    <div class="col s12 m2">
                        <div class="chatters">
                            <h5 class="center-align">Povão conectado</h5>
                            <div class="center-align nicknames">

                            </div>
                        </div>
                    </div>
                    <div class="col s12 m10">
                        <div class="messages">

                        </div>
                    </div>
                </div>

                <div class="card-action">
                    <div class="row custom-row">
                        <div class="input-field col s11">
                            <textarea id="message" class="materialize-textarea flow-text" name="message" placeholder="Digite uma mensagem" rows="1"></textarea>
                        </div>
                        <div class="col s1 center-align">
                            <button class="btn-floating btn-large waves-effect darken-1 send-button" title="Enviar"><i class="material-icons">send</i></button>
                        </div>
                    </div>
                </div>
            </div>          
        </div>     
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="/pschat/bower_components/jquery/dist/jquery.min.js"></script>
        <script type="text/javascript" src="/pschat/bower_components/materialize/dist/js/materialize.min.js"></script>
        <script type="text/javascript" src="/pschat/bower_components/izitoast/dist/js/iziToast.min.js"></script>
        <script>
            $(function () {
                var rtconnection = new WebSocket("ws://" + window.location.host + window.location.pathname);
                rtconnection.onopen = function () {
                    console.log("Conectado com sucesso nesta instância do PSChat");
                };

                var chatters = [];
                function getChatters() {
                    $.ajax("/pschat/chatters", {
                        success: function (data) {
                            var j = JSON.parse(data);
                            if (j.status == 1) {
                                $.each(j.chatters, function (index, element) {
                                    $(".nicknames").append('<div class="chip center-align">\
                                        ' + element.nickname +'\
                                      </div><br/>');
                                });
                            }
                        },
                        cache: false
                    });
                }
                ;
                getChatters();
                
                iziToast.show({position: "topRight", title: '<%=request.getSession().getAttribute("nickname")%>,', message: "Este será seu apelido."})
            });
        </script>
    </body>
</html>
