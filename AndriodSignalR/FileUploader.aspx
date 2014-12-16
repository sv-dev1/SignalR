<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileUploader.aspx.cs" Inherits="AndriodSignalR.FileUploader" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/dropzone.js"></script>
  
    <script type="text/javascript">
        
    </script>
    <style type="text/css">
body {
	padding: 0px;
}
.dropzone .dz-default.dz-message {
	margin: 0px;
	left: 20px;
}
.dropzone .dz-default.dz-message {
	background-position: none;
}
.dropzone {
	min-height: 0px;
	background: none;
	padding: none;
	border: 0;
}
.dz-preview {
	display: none !important;
}
.dropzone .dz-default.dz-message {
	display: block !important;
	opacity: 10 !important;
}
.dropzone .dz-default.dz-message span {
	display: block;
	text-align: left;
	padding-left: 110px;
	padding-top: 15px;
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	font-style: normal;
	color: #8f8f8f;
	background: url('images/upload.png') 20px 0px no-repeat;
	height: 70px;
}
.dz-message {
	display: block;
	text-align: left;
	padding-left: 110px;
	padding-top: 5px;
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	font-style: normal;
	color: #8f8f8f;
	background: url('images/upload.png') 20px 0px no-repeat;
	height: 77px;
}
.dz-message p {
	margin: 0;
}
</style>
    </head>
    <body>
    <form id="frmMain" runat="server" class="dropzone">
      <div class="dz-message" data-dz-message> <span>
        <p>Por favor seleccione documentos a enviar</p>
        <p>Deposite los documentos requeridos en el panel de la izquierda</p>
        <ul>
        <li>- Tipo de archivo PDF </li>
        <li>- Tamaño Maximo xxxMB </li>
      </ul>
        </span> </div>
      <div>
        <div class="fallback">
          <input name="file" type="file" multiple />
        </div>
      </div>
      <script type="text/javascript">
            function DisplayFiles() {

                $.ajax({
                    type: "POST",
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    url: "Fileuploader.aspx/DisplayFiles",
                    //data: "{}",
                    dataType: "json",
                    success: function (data) {
                       // debugger;
                        var str = data.d;
                        //$('#uploaded_files2').html(str);
                        window.parent.document.getElementById('uploaded_files').innerHTML = str;
                    },
                    error: function (xhr) {
                    }
                });
                return false;
            }
              Dropzone.options.frmMain = {
                            init: function () {
                    this.on("complete", function (data) {
                   
                        DisplayFiles();
                    });
                    
                }
                ,
                accept: function (file, done) {
                    window.parent.document.getElementById('err_box').style.display = "none";
                    var re = /(?:\.([^.]+))?$/;
                    var ext = re.exec(file.name)[1];
                    ext = ext.toUpperCase();
                    if (ext == "JPEG" || ext == "PDF" || ext=="JPG") {
                        done();
                    }
                    else {
                      
                        window.parent.document.getElementById('err_box').style.display = "block";
                        window.parent.document.getElementById('errLabel').innerHTML = "Please select files with .pdf or .jpg extensions.";
                        

                    }
                }
            };
        </script>
    </form>
</body>
</html>
