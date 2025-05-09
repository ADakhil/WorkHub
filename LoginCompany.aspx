<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginCompany.aspx.cs" Inherits="workHub.LoginCompany" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - WorkHub</title>
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
    <link rel="stylesheet" href="CreAccCom.css" /> <!-- Using the same CSS as registration -->
    <style>
        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
        .input-error {
            border: 1px solid red !important;
        }
        #errorSummary {
            color: red;
            background-color: #ffeeee;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            display: none;
        }
                .button {
    background-color: white;
    color: #3f51b5;
    padding: 14px 24px;
    border: 2px solid #3f51b5;
    border-radius: 6px;
    cursor: pointer;
    font-size: 18px;
    display: block;
    margin: 25px auto;
    width: fit-content;
    transition: background-color 0.3s ease;
}
.button:hover {
    background-color: #3f51b5 !important;
    color: white;
}
.back-btn{
    padding: 4px 6px;
    border-radius: 5px;
    border: none;
    cursor: pointer;
    color:#283593;
    text-decoration:none;
    background-color:white;
    font-size:12px;
}
.back-btn:hover{
    background-color:#e3e3e3;
    
}
    </style>
</head>
<body>
    <form id="loginForm" runat="server" onsubmit="return validateLoginForm()">
        <div class="container">
            <div class="form-container">
                <div class="left-section">
                    <a class="back-btn" href="HomePageF.aspx">Go Back</a>
                    <h1>Welcome back to<br />WorkHub Platform</h1>
                    <p>Access your company account to manage job postings, review candidates, and streamline your hiring process.</p>
                </div>
                <div class="right-section">
                    <h2>Company Login</h2>
                    
                    <div id="errorSummary" runat="server"></div>
                    
                    <div class="form-group">
                        <label for="txtEmail">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Your company email" />
                        <span id="emailError" class="error-message"></span>
                    </div>

                    <div class="form-group">
                        <label for="txtPassword">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Your password" />
                        <span id="passwordError" class="error-message"></span>
                    </div>

                    <div class="form-group">
                        <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="button" OnClick="btnLogin_Click" />
                    </div>

                    <p class="login-link">
    Don't have an account? <a href="CreAccCom.aspx">Create account</a><br />
    <a href="ForgotPasswordCompany.aspx">Forgot your password?</a>
</p>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function validateLoginForm() {
            // Clear previous errors
            clearErrors();
            
            let isValid = true;
            const errorMessages = [];
            
            // Get form elements
            const email = document.getElementById('<%= txtEmail.ClientID %>');
            const password = document.getElementById('<%= txtPassword.ClientID %>');
            
            // Email validation
            if (email.value.trim() === '') {
                showError(email, 'emailError', 'Email is required');
                errorMessages.push('Email is required');
                isValid = false;
            } else if (!isValidEmail(email.value)) {
                showError(email, 'emailError', 'Please enter a valid email address');
                errorMessages.push('Please enter a valid email address');
                isValid = false;
            }
            
            // Password validation
            if (password.value.trim() === '') {
                showError(password, 'passwordError', 'Password is required');
                errorMessages.push('Password is required');
                isValid = false;
            }
            
            if (!isValid) {
                const errorSummary = document.getElementById('<%= errorSummary.ClientID %>');
                errorSummary.style.display = 'block';
                errorSummary.innerHTML = '<strong>Please correct the following errors:</strong><ul><li>' + 
                    errorMessages.join('</li><li>') + '</li></ul>';
                
                // Scroll to the first error
                const firstError = document.querySelector('.input-error');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
            
            return isValid;
        }
        
        function clearErrors() {
            // Clear error messages
            const errorMessages = document.querySelectorAll('.error-message');
            errorMessages.forEach(el => {
                el.innerText = '';
                el.style.display = 'none';
            });
            
            // Remove error styling
            const errorInputs = document.querySelectorAll('.input-error');
            errorInputs.forEach(el => el.classList.remove('input-error'));
            
            // Clear error summary
            const errorSummary = document.getElementById('<%= errorSummary.ClientID %>');
            errorSummary.style.display = 'none';
            errorSummary.innerHTML = '';
        }
        
        function showError(inputElement, errorSpanId, message) {
            // Highlight the input field
            inputElement.classList.add('input-error');
            
            // Show the error message
            const errorSpan = document.getElementById(errorSpanId);
            errorSpan.innerText = message;
            errorSpan.style.display = 'block';
        }
        
        function isValidEmail(email) {
            const re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            return re.test(email);
        }
    </script>
    <script type="text/javascript">
        window.history.forward();
        function noBack() {
            window.history.forward();
        }
    </script>
</body>
</html>