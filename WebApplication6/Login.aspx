<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication6.Login" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css">
</head>

<body>
    <div class="py-5 cover">
        <div class="container">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="card text-white p-5 bg-primary bg-gradient border-dark">
                        <div class="card-body">
                            <div class="form-control">
                            <h3 style="color: cornflowerblue; margin-bottom: 0px;">Blue </h3>
                            <br />
                                <h3 style="color: darkgray; margin-top: 0px;">Steel</h3>
                                </div>
                            <br>
                            <form id="form1" runat="server" class="text-center">
                                <div>
                                    <asp:Label ID="Label1" runat="server" Text="Username"></asp:Label>
                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="Email" CssClass="form-control input-lg text-center"></asp:TextBox>
                                </div>
                                <div>
                                    <asp:Label ID="Label2" runat="server" Text="Password"></asp:Label>
                                    <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" CssClass="form-control input-lg text-center"></asp:TextBox>
                                </div>
                                <br />
                                <asp:Button ID="Button1" runat="server" OnClick="Button_Click" Text="Log In" Width="202px" CssClass="btn btn-success" />
                                <br />
                            </form>
                            <br />
                            <p class="text-center">
                                <input type="button" href="#" class="btn btn-md btn-success" data-toggle="modal" data-target="#basicModal" style="width: -webkit-fill-available; margin-right: 2px;"
                                    value="Register"></input>
                            </p>
                            <p class="text-center"><a href="register.aspx" style="color: white;">Create a new account</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>


</body>

</html>
