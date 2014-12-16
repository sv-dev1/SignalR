<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AndriodSignalR.Default" %>

<!DOCTYPE html>

<!--<html xmlns="http://www.w3.org/1999/xhtml">-->
<html>
<head runat="server">
    <title>SignalR</title>
    <meta charset="utf-8">
    <!-- Meta -->
    <meta name="keywords" content="" />
    <!-- this styles only adds some repairs on idevices -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Google fonts - witch you want to use - (rest you can just remove) -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,300italic,400,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css' />
    <!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

    <link rel="stylesheet" href="css/style.css" type="text/css" />

    <!-- Roboto Font  -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,500,700' rel='stylesheet' type='text/css'>


    <%--signalr--%>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <%--<script src="Scripts/jquery-1.6.4.min.js"></script>--%>
    <script src="Scripts/jquery.signalR-2.1.2.min.js" type="text/javascript"></script>
    <script src="signalr/hubs" type="text/javascript"></script>

    <%--   colorbox--%>
    <link href="css/colorbox.css" rel="stylesheet" />
    <script src="Scripts/jquery.colorbox.js"></script>


    <%-- bootstrap validation--%>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/bootstrapValidator.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrapValidator.min.js"></script>
    <script src="Scripts/jquery.bootstrap.wizard.js"></script>


    <%--ddlslick--%>
    <script src="Scripts/jquery.ddslick.min.js"></script>

    <%--Uploader
    <link href="css/uploadify.css" rel="stylesheet" />
    <script src="Scripts/jquery.uploadify.js"></script>--%>

    <%-- Hovercard--%>
    <script src="Scripts/jquery.hovercard.js" type="text/javascript"></script>
    <script src="Scripts/dropzone.js" type="text/javascript"></script>

    <script type="text/javascript">
        var globaltick1 = 0;
        var globaltick2 = 0;
        var timeout;


        $(document).on("mouseenter", ".dd-options.dd-click-off-close > li", function () {

            clearTimeout(timeout);
        });
        $(document).on("mouseleave", ".dd-options.dd-click-off-close > li", function () {

            timeout = setTimeout(repeatcall, 4000);
        });


        function getandroidvalue() {
            var value;
            $.ajax(
                {
                    type: "POST",
                   async: false,
                    url: "Default.aspx/GetAndriodDevices",
                    data: '',
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        value = data.d;
                    },
                    failure: function (response) {
                        value = response.d;
                    }
                });
            return value;
        }

        $(function () {

            $('#btn_img').click(function () {
                var data1 = $("#divHTML").html();
                $.colorbox({ html: data1, inline: true, width: "50%", href: "#inline_html", onOpen: AllowPostback });
                return false;
            });

            $('#Acceptar').click(function () {
                $('#div_acceptar1').hide();
                $('#div_firma').show();
                return false;

            });




        });

        function BindImagedropdwon() {
            var index;
            if (parseInt($('#hdnindex').val()) == -1) {
                index = null;
            }
            else {
                index = parseInt($('#hdnindex').val());
            }
            var myNewJsonData = jQuery.parseJSON(getandroidvalue());
            //    alert(myNewJsonData);
            $('#ddlTablet').ddslick('destroy');
            $('#ddlTablet').empty();
            $('#ddlTablet').ddslick({
                data: myNewJsonData,
                width: 450,
                imagePosition: "left",
                selectText: "<img class='dd-option-image' src='images/firma1.png' /><span class='ddl_text'>Select Andriod Device</span>",
                defaultSelectedIndex: index,
                onSelected: function (data) {
                    $('#hdnindex').val(data.selectedIndex);
                    $('#btnActivate').removeClass('linkdisabled');
                    $('#btndeactivate').removeClass('linkdisabled');
                    var description = data.selectedData.description;
                    if (description == "Available") {
                        $('.dd-selected-description').html('Connected');
                        $('#btnActivate,#btndeactivate').removeClass('linkdisabled');

                        var desktop = $('#<%=hdndevicecookie.ClientID%>').val();
                        var hndindustryid = data.selectedData.value;
                        var androidid = data.selectedData.text;
                        $('#hdntabletRegid').val(hndindustryid);
                        $('#hdntabletDeviceid').val(androidid);

                        //debugger;
                        //send push notification
                        if (globaltick1 == 0) {
                            var url1 = "<%=siteurl %>welcome.aspx?deskdevice=" + desktop + "|deviceAND=" + androidid;
                            PushNotification(hndindustryid, androidid, desktop, url1);
                        }
                        $('#PageStatus').show();

                        getpageStatus();

                    }
                    else {

                        $('.dd-selected-description').html('<span style="color:#939393">Disconnected</span>');
                        $('.dd-selected label').css('color', '#eee');
                        $('#btnActivate,#btndeactivate').addClass('linkdisabled');

                        $('.dd-option .dd-option-description dd-desc').css('color', '#000');
                        $('.dd-selected .dd-selected-description').css('color', '#8f8f8f');

                        $('#PageStatus').hide();
                        clearPageconnectionxml(data.selectedData.text);



                    }
                    globaltick1++;

                }


            });


        }


        function clearPageconnectionxml(id) {
            $.ajax({
                type: "POST",
              //  async: false,
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/clearConnectionxmlWithAndriod",
                data: "{'Andriodid':'" + id + "'}",
                dataType: "json",
                success: function (data) {
                },
                error: function (xhr) {
                }
            });
        }


        function BindImagedropdwonStep3() {
            var index;
            if (parseInt($('#hdnindex1').val()) == -1) {
                index = null;
            }
            else {
                index = parseInt($('#hdnindex1').val());
            }

            var myNewJsonData = jQuery.parseJSON(getandroidvalue());
            $('#ddlTablet2').ddslick('destroy');
            $('#ddlTablet2').empty();
            $('#ddlTablet2').ddslick({
                data: myNewJsonData,
                width: 450,
                imagePosition: "left",
                selectText: "<img class='dd-option-image' src='images/firma1.png' /><span class='ddl_text'>Select Andriod Device</span>",
                defaultSelectedIndex: index,
                onSelected: function (data) {
                    $('#hdnindex1').val(data.selectedIndex);
                    $('#btnActivate2').removeClass('linkdisabled');
                    $('#btndeactivate2').removeClass('linkdisabled');
                    var description = data.selectedData.description;
                    if (description == "Available") {

                        $('.dd-selected-description').html('Connected');
                        $('#btnActivate2,#btndeactivate2').removeClass('linkdisabled');
                        var desktop = $('#<%=hdndevicecookie.ClientID%>').val();
                        var hndindustryid = data.selectedData.value;
                        var androidid = data.selectedData.text
                        $('#hdntabletRegid1').val(hndindustryid);
                        $('#hdntabletDeviceid1').val(androidid);


                        if (globaltick2 == 0) {

                            var url1 = "<%=siteurl %>welcome.aspx?deskdevice=" + desktop + "|deviceAND=" + androidid;
                            PushNotification(hndindustryid, androidid, desktop, url1);

                        }

                        $('#PageStatus2').show();
                        getpageStatus2();
                    }
                    else {
                        // debugger;
                        $('.dd-selected-description').html('<span style="color:#939393">Disconnected</span>');
                        $('.dd-selected label').css('color', '#eee');
                        $('#btnActivate2,#btndeactivate2').addClass('linkdisabled');

                        $('.dd-option .dd-option-description dd-desc').css('color', '#000');
                        $('.dd-selected .dd-selected-description').css('color', '#8f8f8f');
                        $('#PageStatus2').hide();

                        clearPageconnectionxml(data.selectedData.text);
                        getpageStatus2();
                    }
                    globaltick2++;
                }

            });

        }


        function repeatcall() {
            getpageStatus();
            getpageStatus2();
            BindImagedropdwon();
            BindImagedropdwonStep3();
            timeout = setTimeout(repeatcall,8000);
        }

    </script>
    <script type="text/javascript">

        $(document).ready(function () {

            UpdateOpentime();
            DisplayFiles();
            repeatcall();   
         
            $('#form1').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    email: {
                        validators: {
                            emailAddress: {
                                message: 'The value is not a valid email address'
                            }
                        }
                    },
                    confirmemail: {
                        validators: {
                            emailAddress: {
                                message: 'The value is not a valid email address'
                            },
                            identical: {
                                field: 'email',
                                message: 'The Coreo and Confimar Coreo are not same'
                            }
                        }
                    },
                }
            });

            $('.form-control').focusout(function () {
                if ($(".help-block:visible").length > 0) {
                    $('li.next').addClass('disabled');
                }
                else {
                    $('li.next').removeClass('disabled');
                }
                return false;
            });


            $('#btnActivate').click(function () {
                var desktop = $('#<%=hdndevicecookie.ClientID%>').val();
                var hndindustryid = $('#hdntabletRegid').val();
                var androidid = $('#hdntabletDeviceid').val();


                if (hndindustryid == '0' || androidid == '0') {
                    alert('Please select Andriod device.');
                    return false;
                }
                else {
                    //send push notification
                    var url1 = "<%=siteurl %>ContractStep1.aspx?deskdevice=" + desktop.trim() + "|deviceAND=" + androidid;
                    PushNotification(hndindustryid, androidid, desktop, url1);
                    $('#btnActivate').hide();
                    $('#btndeactivate').show();
                    $('#PageStatus').show();
                    return false;
                }
                return false;

            });


            $('#btnActivate2').click(function () {
                var desktop = $('#<%=hdndevicecookie.ClientID%>').val();
                      var hndindustryid = $('#hdntabletRegid1').val();
                      var androidid = $('#hdntabletDeviceid1').val();
                      if (hndindustryid == '0' || androidid == '0') {
                          alert('Please select Andriod device.');
                          return false;
                      }
                      else {
                          //send push notification
                          var url1 = "<%=siteurl %>ContractStep1.aspx?deskdevice=" + desktop.trim() + "|deviceAND=" + androidid;
                    PushNotification(hndindustryid, androidid, desktop, url1);
                    $('#btnActivate2').hide();
                    $('#btndeactivate2').show();
                    $('#PageStatus2').show();
                    return false;
                }
                      return false;
                  });

            $('#btndeactivate').click(function () {
                //disconnect tablet
                $('#btnActivate').show();
                $('#btndeactivate').hide();
                $('#PageStatus').hide();
                var desktop = $('#<%=hdndevicecookie.ClientID%>').val();
                var hndindustryid = $('#hdntabletRegid').val();
                var androidid = $('#hdntabletDeviceid').val();
                var url1 = "<%=siteurl %>welcome.aspx?deskdevice=" + desktop.trim() + "|deviceAND=" + androidid;
                PushNotification(hndindustryid, androidid, desktop, url1);
                return false;
            });


            $('#btndeactivate2').click(function () {
                $('#btnActivate2').show();
                $('#btndeactivate2').hide();
                $('#PageStatus2').hide();
                //push notification to take url to welcome page
                var desktop = $('#<%=hdndevicecookie.ClientID%>').val();
                var hndindustryid = $('#hdntabletRegid1').val();
                var androidid = $('#hdntabletDeviceid1').val();
                //send push notification
                var url1 = "<%=siteurl %>welcome.aspx?deskdevice=" + desktop.trim() + "|deviceAND=" + androidid;
                PushNotification(hndindustryid, androidid, desktop, url1);
                return false;
            });

            $('#Modificor').click(function () {
                CloseDialog();
            });


            $("#BtnUpload").click(function (event) {

                var uploadfiles = $("#MultipleFilesUpload").get(0);
                var uploadedfiles = uploadfiles.files;
                var fromdata = new FormData();
                for (var i = 0; i < uploadedfiles.length; i++) {
                    fromdata.append(uploadedfiles[i].name, uploadedfiles[i]);
                }
                var choice = {};
                choice.url = "Upload.ashx";
                choice.type = "POST";
                choice.data = fromdata;
                choice.contentType = false;
                choice.processData = false;
                choice.success = function (result) {
                    var value = result;
                    $('#uploaded_files').html(result);
                };
                choice.error = function (err) {
                    alert(err.statusText);
                };
                $.ajax(choice);
                event.preventDefault();
            });
        });


    </script>
    <script type="text/javascript">
        function DeleteFile(name) {
            //debugger;
            $.ajax({
                type: "POST",
                //async: false,
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/deleteFile",
                data: "{'file':'" + name + "'}",
                dataType: "json",
                success: function (data) {
                    DisplayFiles();
                },
                error: function (xhr) {
                }
            });
        }

        function DisplayFiles() {
            $.ajax({
                type: "POST",
                //async: false,
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/DisplayFiles",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    var str = data.d;
                    $('#uploaded_files').html(str);
                },
                error: function (xhr) {
                }
            });
            return false;
        }


        var refresh = false;
        //disable refresh key
        $(function () {
            $(document).keydown(function (e) {
                return (e.which || e.keyCode) != 116;
            });
            $("#failure").hovercard({
                detailsHTML:"<span>Factura teelfonica</span> <br/> <p>Detailed description of unsolvable problem</p>",
                width: 400

            });

        });

        $(window).bind("beforeunload", function (e) {
            if (refresh == false) {
                UpdateClosetime();
            }
        });

        function AllowPostback() {
            $("#colorbox, #cboxOverlay").appendTo('form:first');
        }

        function PushNotification(hdIndustryId, devicename, desktopid, url) {
            var res;
            var chat = $.connection.chatHub;
            $.connection.hub.start().done(function () {
                var message = desktopid + "|" + url;
              //  debugger;
                 res = chat.server.send(hdIndustryId, message, devicename, desktopid);
               // debugger;
                return false;
            });
        }

        function UpdateClosetime() {  //desktop close
            $.ajax({
                type: "POST",
                //async: false,
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/UpdateClosetime",
                data: "{'deviceID':'" + $('#hdndevicecookie').val() + "'}",
                dataType: "json",
                success: function (data) {

                },
                error: function (xhr) {
                }
            });
        }
        function UpdateOpentime() {  //desktop open

            $.ajax({
                type: "POST",
                //async: false,
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/UpdateOpentime",
                data: "{'deviceID':'" + $('#hdndevicecookie').val() + "'}",
                dataType: "json",
                success: function (data) {

                },
                error: function (xhr) {
                }
            });
        }

        function getpageStatus() {
            var desktop = $('#<%=hdndevicecookie.ClientID%>').val();
            var androidid = $('#hdntabletDeviceid').val();
            $.ajax({
                type: "POST",
                //async: false,
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/GetPagestatus",
                data: "{'desktopdeviceid':'" + desktop + "','andriodid':'" + androidid + "'}",
                dataType: "json",
                success: function (data) {

                    var str = data.d;
                    if (str != "") {
                        if (str == "0") {
                            $('#step1').css('display', 'none');
                            $('#step2').css('display', 'none');
                        }

                        else if (str == "2" || str == "3") {
                            $('#step1').css('display', 'block');
                            $('#step2').css('display', 'none');

                        }
                        else if (str == "4") {
                            $('#step1').css('display', 'none');
                            $('#step2').css('display', 'block');

                            $('#btndeactivate').addClass('disabled');


                        }
                    }
                    else {

                        $('#step1').css('display', 'none');
                        $('#step2').css('display', 'none');

                        $('#btndeactivate').hide();
                        $('#btnActivate').show();

                    }
                },
                error: function (xhr) {
                }
            });
        }

        function getpageStatus2() {
            var desktop = $('#<%=hdndevicecookie.ClientID%>').val();
            var androidid = $('#hdntabletDeviceid1').val();
            $.ajax({
                type: "POST",
                //async: false,
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/GetPagestatus",
                data: "{'desktopdeviceid':'" + desktop + "','andriodid':'" + androidid + "'}",
                dataType: "json",
                success: function (data) {

                    var str = data.d;
                    if (str != "") {
                        if (str == "0") {
                            $('#step3').css('display', 'none');
                            $('#step4').css('display', 'none');
                        }

                        else if (str == "2" || str == "3") {
                            $('#step3').css('display', 'block');
                            $('#step4').css('display', 'none');

                        }
                        else if (str == "4") {
                            $('#step3').css('display', 'none');
                            $('#step4').css('display', 'block');

                            $('#btndeactivate2').addClass('disabled');


                        }
                    }
                    else {

                        $('#step3').css('display', 'none');
                        $('#step4').css('display', 'none');

                        $('#btndeactivate2').hide();
                        $('#btnActivate2').show();

                    }
                },
                error: function (xhr) {
                }
            });
        }
    </script>




</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdndevicecookie" ClientIDMode="Static" runat="server" Value="" />
        <input id="hdntabletRegid" value="0" type="hidden" />
        <input id="hdntabletDeviceid" value="0" type="hidden" />
        <input id="hdnindex" value="-1" type="hidden" />


        <input id="hdntabletRegid1" value="0" type="hidden" />
        <input id="hdntabletDeviceid1" value="0" type="hidden" />
        <input id="hdnindex1" value="-1" type="hidden" />


        <div class="spl901">
            <%--<input type="button" id="btn_img" value="Click me" />--%>
            <img id="btn_img"  src="images/main-image.jpg" />
        </div>


        <div class="main-cont" id="divHTML">
            <div style='display: none' class="popup">
                <div id='inline_html'>
                    <div>
                        <div class="pop_header">
                            <div class="head-left">
                                <img src="images/head-icon.png" width="39" height="42" align="absmiddle">
                                <h1>Firma Digital</h1>
                            </div>
                            <div class="head-right">
                                <ul>
                                   <%-- <li><a href="">
                                        <img src="images/icon2.png" width="21" height="21"></a></li>
                                    <li><a href="">
                                        <img src="images/icon1.png" width="21" height="21"></a></li>--%>
                                    <li><a href="#" onclick="CloseDialog();">
                                        <img src="images/close-icon.png" width="21" height="21" /></a></li>
                                </ul>
                            </div>
                        </div>
                        <div id="rootwizard" style="padding-top: 5%">
                            <div class="navbar spl221">
                                <div class="navbar-inner">
                                    <div class="tabbing_section">
                                        <ul>
                                            <li class="grey">Email    
                                                          <a href="#tab1" style="cursor: default" data-toggle="tab">
                                                              <div class="absolute_step white">
                                                                  <span>
                                                                      <label>1</label>
                                                                      <img src="images/pencil-icon.png" width="14" height="12" align="absmiddle"></span>
                                                              </div>
                                                          </a>

                                            </li>
                                            <li class="grey">Firma Solicidud<a href="#tab2" style="cursor: default" data-toggle="tab">
                                                <div class="absolute_step gray">
                                                    <span>
                                                        <label>2</label>
                                                        <img src="images/fade_tick.png" width="14" height="12" align="absmiddle"></span>
                                                </div>
                                            </a></li>
                                            <li class="grey">Firma Contraro <a style="cursor: default" href="#tab3" data-toggle="tab">
                                                <div class="absolute_step gray">
                                                    <span>
                                                        <label>3</label><img src="images/fade_tick.png" width="14" height="12" align="absmiddle"></span>
                                                </div>
                                            </a>

                                            </li>
                                            <li class="grey">Documentacion<a style="cursor: default" href="#tab4" data-toggle="tab">
                                                <div class="absolute_step gray">
                                                    <span>
                                                        <label>4</label><img src="images/fade_tick.png" width="14" height="12" align="absmiddle"></span>
                                                </div>
                                            </a></li>
                                            <li class="grey">Finalizar<a style="cursor: default" href="#tab5" data-toggle="tab">
                                                <div class="absolute_step gray">
                                                    <span>
                                                        <label>5</label><img src="images/fade_tick.png" width="14" height="12" align="absmiddle"></span>
                                                </div>
                                            </a></li>

                                        </ul>
                                    </div>
                                </div>
                            </div>



                            <div class="container-box tab-content spl200">

                                <%--TAB 1--%>
                                <div class="tab-pane spl206" id="tab1">
                                    <div class="left-cont spl201">
                                           <div class="course-btn spl222">
                                               <span class="spl902"><img src="images/usericon.jpg" width="18" align="absmiddle"></span>
                                            <p class="spl903"> Micheal Mayers <br/>
<span style="color:#8f8f8f;">12345678-A
                                           </span></p>
                                        </div>
                                        <div class="course-btn spl215">
                                            <img src="images/in-course.png" width="18" height="23" align="absmiddle">
                                            In Course
                                        </div>
                                        <div class="box_left spl204">
                                            <p class="head spl205">
                                                <img src="images/note-icon.png" width="24" height="27" align="absmiddle" style="margin-right: 10px;">
                                                Poliza
                                            </p>
                                            <div class="table_data">
                                                <div>
                                                    <div class="data-lft">Importe</div>
                                                    <div class="data-rht">300 €</div>
                                                </div>
                                                <br />
                                                <div>
                                                    <div class="data-lft">Plazo</div>
                                                    <div class="data-rht">24 meses</div>
                                                </div>
                                                <br />
                                                <div>
                                                    <div class="data-lft">Cuota</div>
                                                    <div class="data-rht">2.550 €</div>
                                                </div>
                                                <a href="" class="modificer-btn Modificor">Modificar</a>

                                            </div>
                                        </div>
                                        
                                    </div>
                                    <div class="right_cont spl2022" style="height:500px;">
                                        <h1 class="spl218">Confirmar direccion de correo electronico</h1>
                                        <div class="green-box spl218" style="border:none;">
                                            <div class="lft_green" style="border:solid 1px #ffdb7a; border-right:solid 1px #ffc322;">
                                                <img src="images/icon3.png" style="margin: 43% 20% !important;" >
                                            </div>
                                            <div class="rht-green" style="border:solid 1px #ffc322; border-left:0;">
                                                <p style="padding-top:0px !important; margin-bottom:0px!important">
                                                   Confirme que el cliente procederà con la firma digital, para poder continuar es necesario verificar la 
                                                   dirección de correo electrónico. Si el cliente no acepta la firma electrónica pulse en 
                                                   <a href="#">Firma Manuscrita</a>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="bordered_div">
                                            <div class="row form-group">
                                                <div class="col-md-3 left_space">Correo electronico</div>
                                                <div class="col-md-5">
                                                    <input type="text" id="email1" class="form-control" name="email" />
                                                </div>
                                            </div>
                                            <div class="row form-group">
                                                <div class="col-md-3 left_space">Confirmar Correro</div>
                                                <div class="col-md-5">
                                                    <input type="text" id="email2" class="form-control" name="confirmemail" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br style="clear: both" />
                                </div>


                                <%--TAB 2--%>

                                <div class="tab-pane spl206 md90" id="tab2">
                                    <div class="left-cont spl201">
                                        <div class="course-btn spl222">
                                               <span class="spl902"><img src="images/usericon.jpg" width="18" align="absmiddle"></span>
                                            <p class="spl903"> Micheal Mayers <br/>
<span style="color:#8f8f8f;">12345678-A
                                           </span></p>
                                        </div>

                                        <div class="course-btn spl215">
                                            <img src="images/in-course.png" width="18" height="23" align="absmiddle">
                                            In Course
                                        </div>
                                        <div class="box_left spl204">
                                            <p class="head spl205">
                                                <img src="images/note-icon.png" width="24" height="27" align="absmiddle" style="margin-right: 10px;">
                                                Poliza
                                            </p>
                                            <div class="table_data">
                                                <div>
                                                    <div class="data-lft">Importe</div>
                                                    <div class="data-rht">300 €</div>
                                                </div>
                                                <br />
                                                <div>
                                                    <div class="data-lft">Plazo</div>
                                                    <div class="data-rht">24 meses</div>
                                                </div>
                                                <br />
                                                <div>
                                                    <div class="data-lft">Cuota</div>
                                                    <div class="data-rht">2.550 €</div>
                                                </div>
                                                <a href="" class="modificer-btn Modificor">Modificar</a>

                                            </div>
                                        </div>

                                    </div>
                                    <div class="right_cont spl2022" style="height:500px;">
                                        <h1 class="spl218">Documentacion de Firma</h1>

                                        <div class="download_area">
                                            <div class="download_area_bx1">
                                                <div class="download_area_bx1_lft">
                                                    <img src="images/pdf.png" alt="">
                                                </div>
                                                <a href="#">Document1.pdf</a>
                                                <span>2.2 mb</span>
                                            </div>
                                            <div class="download_area_bx1">
                                                <div class="download_area_bx1_lft">
                                                    <img src="images/xls.png" alt="">
                                                </div>
                                                <a href="#">Document2.pdf</a>
                                                <span>2.2 mb</span>
                                            </div>
                                        </div>

                                        <div class="bordered_div">
                                            <h1 class="spl218">Firma</h1>
                                            <div class="download_area">
                                                <div id="ddlTablet"></div>
                                            </div>


                                            <input type="button" id="btnActivate" class="pagebutton" value="Activar Firma" />
                                            <input type="button" id="btndeactivate" class="activeButton" value="Desactivar Firma" />


                                            <div class="Paging" id="PageStatus" style="display: none;">

                                                <div id="step1" class="firma_gray spl218" style="background: #f4f4f4;">
                                                    <div class="lft_green" style="background: #fafafa;">
                                                        <img src="images/gray-icon.png" style="margin:15% 20%;">
                                                    </div>
                                                    <div class="rht-green" style="padding:0 2%;">
                                                        <h4 style="color:#696969; padding-top:0; margin-bottom:0; margin-top:8px; font-size:16px; font-weight:bold;">Proceso de firma en curso</h4>
                                                         <p style="font-weight:normal;  margin-top: 2px; font-size:13px;">El dispositivo mostrara el contraro y se abilitara el quadro de firma</p>
                                                    </div>
                                                </div>
                                                 <div id="step2" class="firma_gray spl218" style="background: #e6f6c5; border:solid 1px #bedd82;">
                                                    <div class="lft_green" style="background: #eef9db;">
                                                        <img src="images/green-icon.png" style="margin:15% 20%;">
                                                    </div>
                                                    <div class="rht-green" style="padding:0 2%;">
                                                        <h4 style="color:#6aa400; padding-top:0; margin-bottom:0; margin-top:8px; font-size:16px; font-weight:bold;">Firma completada</h4>
                                                         <p style="color:#6aa400; font-weight:normal;  margin-top: 2px; font-size:13px;">Los documentos firmados y listos para <span style="color:#404040; text-decoration:underline;">Imrimir</span></p>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <br style="clear: both" />
                                </div>



                                <%--  TAB 3--%>
                                <div class="tab-pane spl206" id="tab3">
                                    <div class="left-cont spl201">
                                           <div class="course-btn spl222">
                                               <span class="spl902"><img src="images/usericon.jpg" width="18" align="absmiddle"></span>
                                            <p class="spl903"> Micheal Mayers <br/>
<span style="color:#8f8f8f;">12345678-A
                                           </span></p>
                                        </div>
                                        <div class="course-btn spl215" style="color: rgb(235,178,0)">
                                              <img width="31" height="36" align="absmiddle" src="images/condionada.png" style="margin:0px">
                                            Condicionada
                                        </div>
                                        <div class="box_left spl204">
                                            <p class="head spl205">
                                                <img src="images/note-icon.png" width="24" height="27" align="absmiddle" style="margin-right: 10px;">
                                                Poliza
                                            </p>
                                            <div class="table_data">
                                                <div>
                                                    <div class="data-lft">Importe</div>
                                                    <div class="data-rht">300 €</div>
                                                </div>
                                                <br />
                                                <div>
                                                    <div class="data-lft">Plazo</div>
                                                    <div class="data-rht">24 meses</div>
                                                </div>
                                                <br />
                                                <div>
                                                    <div class="data-lft">Cuota</div>
                                                    <div class="data-rht">2.550 €</div>
                                                </div>
                                                <a href="" class="modificer-btn Modificor">Modificar</a>

                                            </div>
                                        </div>
                                   
                                    </div>
                                    <div class="right_cont spl2022" style="height:500px;">
                                        <h1 class="spl218">Firma de contrato</h1>

                                        <div id="div_acceptar1">
                                           <div class="green-box spl218" style="border:none;">
                                            <div class="lft_green" style="border:solid 1px #ffdb7a; border-right:solid 1px #ffc322;">
                                                    <img src="images/icon3.png" style="margin: 43% 20% !important;">
                                                </div>
                                                <div class="rht-green" style="border:solid 1px #ffc322; border-left:0;">
                                                       <p style="padding-top:0px !important; margin-bottom:0px!important">
                                                        Confirm that the customer will proceed with the Digital Signature.
An e-mail verification is required. In case the customer do not accept Digital Signature click on the following link to start Manual Signature.
                                                    </p>
                                                </div>
                                            </div>
                                            <form>

                                                <div class="AcceptarBox">
                                                    <div class="field_outer">
                                                        <label>
                                                            Cargo publico
                                                        </label>
                                                        <select id="ddl1">
                                                            <option>Selecctionar</option>
                                                        </select>
                                                    </div>
                                                    <div class="field_outer">
                                                        <label>
                                                            Funcion
                                                        </label>
                                                        <input type="text" />
                                                    </div>
                                                    <div class="field_outer">
                                                        <label>
                                                            Cargo publico
                                                        </label>
                                                        <select id="ddl1">
                                                            <option>Selecctionar</option>
                                                        </select>
                                                    </div>
                                                    <div class="field_outer">
                                                        <label>
                                                            Funcion
                                                        </label>
                                                        <input type="text" />
                                                    </div>

                                                    <input type="button" id="Acceptar" value="Acceptar" class="signature-btn no-rht-mrgn" />
                                                </div>
                                            </form>
                                        </div>

                                        <div id="div_firma" style="display: none;">
                                            <div class="download_area">
                                                <div class="download_area_bx1">
                                                    <div class="download_area_bx1_lft">
                                                        <img src="images/pdf.png" alt="">
                                                    </div>
                                                    <a href="#">Informacion.pdf</a>
                                                    <span>2.2 mb</span>
                                                </div>
                                                <div class="download_area_bx1">
                                                    <div class="download_area_bx1_lft">
                                                        <img src="images/xls.png" alt="">
                                                    </div>
                                                    <a href="#">FileNAmeLong v2.xls</a>
                                                    <span>2.2 mb</span>
                                                </div>
                                            </div>
                                            <div class="bordered_div">
                                                <h1 class="spl218">Firma</h1>
                                                <div class="download_area">
                                                    <div id="ddlTablet2"></div>
                                                </div>
                                                <input type="button" id="btnActivate2" class="pagebutton" value="Activar Firma" />
                                                <input type="button" id="btndeactivate2" class="activeButton" value="Desactivar Firma" />

                                            </div>
                                            <div class="Paging" id="PageStatus2" style="display: none;">
                                             
                                                   <div id="step3" class="firma_gray spl218" style="background: #f4f4f4;">
                                                    <div class="lft_green" style="background: #fafafa;">
                                                        <img src="images/gray-icon.png" style="margin:15% 20%;">
                                                    </div>
                                                    <div class="rht-green" style="padding:0 2%;">
                                                        <h4 style="color:#696969; padding-top:0; margin-bottom:0; margin-top:8px; font-size:16px; font-weight:bold;">Proceso de firma en curso</h4>
                                                         <p style="font-weight:normal;  margin-top: 2px; font-size:13px;">El dispositivo mostrara el contraro y se abilitara el quadro de firma</p>
                                                    </div>
                                                </div>
                                                 <div id="step4" class="firma_gray spl218" style="background: #e6f6c5; border:solid 1px #bedd82;">
                                                    <div class="lft_green" style="background: #eef9db;">
                                                        <img src="images/green-icon.png" style="margin:15% 20%;">
                                                    </div>
                                                    <div class="rht-green" style="padding:0 2%;">
                                                        <h4 style="color:#6aa400; padding-top:0; margin-bottom:0; margin-top:8px; font-size:16px; font-weight:bold;">Firma completada</h4>
                                                         <p style="color:#6aa400; font-weight:normal;  margin-top: 2px; font-size:13px;">Los documentos firmados y listos para <span style="color:#404040; text-decoration:underline;">Imrimir</span></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <br style="clear: both" />
                                    </div>

                                </div>
                                <%--TAB 4--%>
                                <div class="tab-pane spl206" id="tab4">
                                    <div class="left-cont spl201">
                                         <div class="course-btn spl222">
                                               <span class="spl902"><img src="images/usericon.jpg" width="18" align="absmiddle"></span>
                                            <p class="spl903"> Micheal Mayers <br/>
<span style="color:#8f8f8f;">12345678-A
                                           </span></p>
                                        </div>
                                        <div class="course-btn spl215">
                                            <img src="images/tick3.png" width="24" height="24" align="absmiddle">
                                            Aprobada
                                        </div>
                                        <div class="box_left spl204">
                                            <p class="head spl205">
                                                <img src="images/note-icon.png" width="24" height="27" align="absmiddle" style="margin-right: 10px;">
                                                Poliza
                                            </p>
                                            <div class="table_data">
                                                <div>
                                                    <div class="data-lft">Importe</div>
                                                    <div class="data-rht">300 €</div>
                                                </div>
                                                <br />
                                                <div>
                                                    <div class="data-lft">Plazo</div>
                                                    <div class="data-rht">24 meses</div>
                                                </div>
                                                <br />
                                                <div>
                                                    <div class="data-lft">Cuota</div>
                                                    <div class="data-rht">2.550 €</div>
                                                </div>
                                                <a href="" class="modificer-btn Modificor">Modificar</a>

                                            </div>
                                        </div>
                                        <div class="box_left spl204">
                                            <p class="head spl205">
                                                <img src="images/notes-icon.png" width="22" height="25" align="absmiddle" style="margin-right: 8px;">
                                                Documentacion
                                            </p>

                                            <div>
                                                <strong class="center-head" style="margin-top: 10px;">Alehandro Martinez Garcia</strong>
                                                <ul class="small_list sg719">
                                                    <li>Nomia o justificante</li>
                                                    <li>Justificante banco</li>
                                                    <li id="failure" style="background-image: url(images/failureicon.png)">Factura teelfonica</li>
                                                </ul>
                                            </div>
                                            <div>
                                                <strong class="center-head">Alehandro Martinez Garcia</strong>
                                                <ul class="small_list last">
                                                    <li>Nomia o justificante</li>
                                                    <li>Justificante banco</li>
                                                    <li>Factura teelfonica</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="right_cont spl2022" style="height:674px;">
                                        <h1 class="left_heading">Ajuntar documentos</h1>

                                        <div class="download_area_bx1 spl300">
                                            <select>
                                                <option>Scanner</option>
                                                <option>feb</option>
                                                <option>mar</option>
                                                <option>apr</option>
                                            </select>

                                        </div>

                                        <div class="error_bar" style="display:none;" id="err_box">
                                            <div class="img_box">
                                                <img src="images/error-icon.png" align="absmiddle">
                                            </div>
                                            <p class="msg-err"  id="errLabel">Todos los documentos daben ser revisados para poder continuar</p>
                                        </div>

                                        <div style="float: left; width: 100%; margin: 10px 0;">


                                            <%--file uploader--%>
                                            <div class="dashedarea">
                                                <iframe src="FileUploader.aspx" style="border: 0px; width: 100%; height:130px;"></iframe>
                                             
                                            </div>

                                            <div id="uploaded_files"></div>
                                        </div>
                                    </div>

                                    <br style="clear: both" />
                                </div>
                                <%--TAB 5--%>
                                <div class="tab-pane" id="tab5">
                                    <div class="left-cont spl201">
                                       <div class="course-btn spl222">
                                               <span class="spl902"><img src="images/usericon.jpg" width="18" align="absmiddle"></span>
                                            <p class="spl903"> Micheal Mayers <br/>
<span style="color:#8f8f8f;">12345678-A
                                           </span></p>
                                        </div>

                                        <div class="course-btn spl215">
                                            <img src="images/tick3.png" width="24" height="24" align="absmiddle">
                                            Aprobada
                                        </div>
                                        <div class="box_left spl204">
                                            <p class="head spl205">
                                                <img src="images/note-icon.png" width="24" height="27" align="absmiddle" style="margin-right: 10px;">
                                                Poliza
                                            </p>
                                            <div class="table_data">
                                                <div>
                                                    <div class="data-lft">Importe</div>
                                                    <div class="data-rht">300 €</div>
                                                </div>
                                                <br />
                                                <div>
                                                    <div class="data-lft">Plazo</div>
                                                    <div class="data-rht">24 meses</div>
                                                </div>
                                                <br />
                                                <div>
                                                    <div class="data-lft">Cuota</div>
                                                    <div class="data-rht">2.550 €</div>
                                                </div>
                                                <a href="" class="modificer-btn Modificor">Modificar</a>

                                            </div>
                                        </div>
                                        <div class="box_left spl204">
                                            <p class="head spl205">
                                                <img src="images/notes-icon.png" width="22" height="25" align="absmiddle" style="margin-right: 8px;">
                                                Documentacion
                                            </p>

                                            <div>
                                                <strong class="center-head" style="margin-top: 10px;">Alehandro Martinez Garcia</strong>
                                                <ul class="small_list sg719">
                                                    <li>Nomia o justificante</li>
                                                    <li>Justificante banco</li>
                                                    <li>Factura teelfonica</li>
                                                </ul>
                                            </div>
                                            <div>
                                                <strong class="center-head">Alehandro Martinez Garcia</strong>
                                                <ul class="small_list sg719 last">
                                                    <li>Nomia o justificante</li>
                                                    <li>Justificante banco</li>
                                                    <li>Factura teelfonica</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="right_cont spl2022" style="height:678px;">
                                        <h1 class="left_heading">Finalizar Contratacion</h1>

                                          <div class="green-box spl218" style="background: #d9e6be; border: solid 1px #aad748; border-radius: 5px;box-shadow:0 1px 2px 0 #9f9f9f;">
                                            <div class="lft_green" style="background: #eaf1db; border-right: solid 1px #aad748;">
                                                <img src="images/icon_final.png" style="margin:32% 20%;">
                                            </div>
                                            <div class="rht-green" style="padding:1%;"> 
                                                <p class="green_text">
                                                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's
standard dummy text ever since the
                                                </p>
                                            </div>
                                        </div>
                                        <div class="shadow_box">
                                            <div class="shadow_head">
                                                <h3><span>Numero Contrato</span>
                                                    <label>3214345552</label>
                                                    <span class="date">15 June 2014</span></h3>
                                            </div>

                                            <div class="shadow_white_area">
                                                <div class="cont_details">
                                                    <img src="images/sample-img.png" alt="" align="absmiddle" />
                                                    <h4>Alejandro Martinez Garzia</h4>
                                                    <p>2131232190,   15 June 1985</p>
                                                </div>
                                                <div class="rht-box">
                                                    <p>Importe Operacion</p>
                                                    <h3>£ 2.311,23</h3>
                                                </div>
                                            </div>

                                            <div class="print_btn_area">
                                                <a href="" class="signature-btn print">
                                                    <img src="images/print.png" alt="" align="absmiddle" />
                                                    Imprimir</a>
                                            </div>

                                        </div>

                                    </div>


                                    <br style="clear: both" />
                                </div>
                                <ul class="pager wizard">

                                    <li class="previous"><a class="calender-btn" href="javascript:;">Anterior</a></li>
                                    <li class="next"><a class="signature-btn" href="javascript:;">Siguiente</a></li>
                                    <li class="next finish" style="display: none;"><a class="signature-btn" href="javascript:;">Finalizar</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
    <script type="text/javascript">
        var CheckPreviousNext = 0;
        $(document).ready(function () {
            $('#rootwizard').bootstrapWizard({
                onTabShow: function (tab, navigation, index) {
                    // debugger;
                    if (CheckPreviousNext == 1) {
                        // debugger;
                        $(tab).children().children().removeClass('gray').addClass('white');
                        $(tab).children().children().children().children().attr('src', 'images/pencil-icon.png');
                        $(tab).prev().removeClass('grey').addClass('active-step');
                        $(tab).prev().children().children().removeClass("white");
                        $(tab).prev().children().children().children().children().attr('src', 'images/white_tick.png');


                    }
                    else if (CheckPreviousNext == 2) {
                        if (index == 0) {
                            //debugger;
                            $(tab).next().removeClass('grey').addClass('active-step');
                            $(tab).next().children().children().children().children().attr('src', 'images/white_tick.png');
                            $(tab).next().children().children().removeClass('white');
                            $(tab).removeClass('active-step');
                            $(tab).children().children().children().children().attr('src', 'images/pencil-icon.png');
                            $(tab).children().children().addClass('white');
                        }
                        else {

                            $(tab).next().removeClass('grey').addClass('active-step');
                            $(tab).next().children().children().children().children().attr('src', 'images/white_tick.png');
                            $(tab).next().children().children().removeClass('white');
                            $(tab).removeClass('active-step');
                            $(tab).children().children().children().children().attr('src', 'images/pencil-icon.png');
                            $(tab).children().children().addClass('white');

                        }
                    }


                    var $total = navigation.find('li').length;
                    var $current = index + 1;
                    var $percent = ($current / $total) * 100;
                    $('#rootwizard').find('.bar').css({ width: $percent + '%' });
                    // If it's the last tab then hide the last button and show the finish instead
                    if ($current >= $total) {
                        $('#rootwizard').find('.pager .next').hide();
                        $('#rootwizard').find('.pager .finish').show();
                        $('#rootwizard').find('.pager .finish').removeClass('disabled');
                    } else {
                        $('#rootwizard').find('.pager .next').show();
                        $('#rootwizard').find('.pager .finish').hide();
                    }
                },
                onTabClick: function (tab, navigation, index) {
                    return false;
                },

                onNext: function (tab, navigation, index) {
                    CheckPreviousNext = 1;
                },

                onPrevious: function (tab, navigation, index) {
                    CheckPreviousNext = 2;
                }
            });

        });
        function CloseDialog() {
            $.colorbox.close();
            return false;
        }
    </script>
</body>
</html>
