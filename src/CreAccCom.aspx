<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreAccCom.aspx.cs" Inherits="workHub.CreAccCom" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WorkHub Registration</title>
    <link rel="stylesheet" href="CreAccCom.css" />
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
    <form id="registrationForm" runat="server" onsubmit="return validateForm()">
        <div class="container">
            <div class="form-container">
                <div class="left-section">
                    <a class="back-btn" href="HomePageF.aspx">Go Back</a>
                    <h1>Welcome to<br />WorkHub Platform</h1>
                    <p>Join WorkHub Today. Recruit smarter with WorkHub. Create your account to post job openings, filter candidates, and organize applications—all in one place.</p>
                </div>
                <div class="right-section">
                    <h2>Create an account</h2>
                    
                    <asp:Label ID="errorSummary" runat="server" CssClass="error-message" ClientIDMode="Static"></asp:Label>
                    
                    <div class="form-group">
                        <label for="companyName">Company Name *</label>
                        <asp:TextBox ID="companyName" runat="server" CssClass="form-control" placeholder="Full legal name of the company" ClientIDMode="Static" />
                        <span id="companyNameError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group">
                        <label for="emailAddress">Email Address *</label>
                        <asp:TextBox ID="emailAddress" runat="server" CssClass="form-control" placeholder="Company email" ClientIDMode="Static" />
                        <span id="emailAddressError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group">
                        <label for="password">Password *</label>
                        <asp:TextBox ID="password" runat="server" CssClass="form-control" TextMode="Password" placeholder="Minimum 8 characters" ClientIDMode="Static" />
                        <span id="passwordError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password *</label>
                        <asp:TextBox ID="confirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Re-enter your password" ClientIDMode="Static" />
                        <span id="confirmPasswordError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber">Phone Number *</label>
                        <div class="phone-input">
                            <asp:DropDownList ID="countryCode" runat="server" ClientIDMode="Static">
                                <asp:ListItem Text="+966" Value="+966" />
                                <asp:ListItem Text="+1" Value="+1" />
                            </asp:DropDownList>
                            <asp:TextBox ID="phoneNumber" runat="server" CssClass="form-control" placeholder="Phone Number" ClientIDMode="Static" />
                        </div>
                        <span id="phoneNumberError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group">
                        <label for="website">Company Website (Optional)</label>
                        <asp:TextBox ID="website" runat="server" CssClass="form-control" placeholder="https://example.com" ClientIDMode="Static" />
                        <span id="websiteError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group">
                        <label for="industry">Industry *</label>
                        <asp:TextBox ID="industry" runat="server" CssClass="form-control" placeholder="e.g., Technology, Retail" ClientIDMode="Static" />
                        <span id="industryError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group">
                        <label for="location">Location *</label>
                        <asp:TextBox ID="location" runat="server" CssClass="form-control" placeholder="Company location" ClientIDMode="Static" />
                        <span id="locationError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group">
                        <label for="logoUpload">Logo (Optional)</label>
                        <asp:FileUpload ID="logoUpload" runat="server" ClientIDMode="Static" />
                        <span id="logoUploadError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group">
    <label for="ddlSecurityQuestion">Security Question *</label>
    <asp:DropDownList ID="ddlSecurityQuestion" runat="server" CssClass="form-control" ClientIDMode="Static">
        <asp:ListItem Text="Select a security question" Value="" />
        <asp:ListItem Text="What was your first pet's name?" Value="pet" />
        <asp:ListItem Text="What city were you born in?" Value="city" />
        <asp:ListItem Text="What is your mother's maiden name?" Value="mother" />
        <asp:ListItem Text="What was the name of your first school?" Value="school" />
        <asp:ListItem Text="Custom question..." Value="custom" />
    </asp:DropDownList>
    <span id="securityQuestionError" class="error-message" runat="server"></span>
</div>

<div class="form-group" id="customQuestionGroup" style="display:none;">
    <label for="txtCustomQuestion">Your Custom Question *</label>
    <asp:TextBox ID="txtCustomQuestion" runat="server" CssClass="form-control" ClientIDMode="Static" />
    <span id="customQuestionError" class="error-message" runat="server"></span>
</div>

<div class="form-group">
    <label for="txtSecurityAnswer">Security Answer *</label>
    <asp:TextBox ID="txtSecurityAnswer" runat="server" CssClass="form-control" TextMode="Password" ClientIDMode="Static" />
    <span id="securityAnswerError" class="error-message" runat="server"></span>
</div>

                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="button" OnClick="btnRegister_Click" OnClientClick="return validateForm();" />

                    <p class="login-link">Already have an account? <a href="LoginCompany.aspx">Log in</a></p>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function validateForm() {
            try {
                // Clear previous errors
                clearErrors();

                let isValid = true;
                const errorMessages = [];

                // Get form elements
                const companyName = document.getElementById('<%= companyName.ClientID %>');
                const email = document.getElementById('<%= emailAddress.ClientID %>');
                const password = document.getElementById('<%= password.ClientID %>');
                const confirmPassword = document.getElementById('<%= confirmPassword.ClientID %>');
                const phoneNumber = document.getElementById('<%= phoneNumber.ClientID %>');
                const website = document.getElementById('<%= website.ClientID %>');
                const industry = document.getElementById('<%= industry.ClientID %>');
                const location = document.getElementById('<%= location.ClientID %>');
                const logoUpload = document.getElementById('<%= logoUpload.ClientID %>');
                const securityQuestion = document.getElementById('<%= ddlSecurityQuestion.ClientID %>');
                const securityAnswer = document.getElementById('<%= txtSecurityAnswer.ClientID %>');
                const customQuestion = document.getElementById('<%= txtCustomQuestion.ClientID %>');

                if (securityQuestion.value === '') {
                    showError(securityQuestion, 'securityQuestionError', 'Security question is required');
                    errorMessages.push('Security question is required');
                    isValid = false;
                } else if (securityQuestion.value === 'custom' && customQuestion.value.trim() === '') {
                    showError(customQuestion, 'customQuestionError', 'Custom question is required');
                    errorMessages.push('Custom question is required');
                    isValid = false;
                }

                // Security Answer validation
                if (securityAnswer.value.trim() === '') {
                    showError(securityAnswer, 'securityAnswerError', 'Security answer is required');
                    errorMessages.push('Security answer is required');
                    isValid = false;
                }
                
                // Company Name validation
                if (companyName.value.trim() === '') {
                    showError(companyName, 'companyNameError', 'Company name is required');
                    errorMessages.push('Company name is required');
                    isValid = false;
                }
                
                // Email validation
                if (email.value.trim() === '') {
                    showError(email, 'emailAddressError', 'Email is required');
                    errorMessages.push('Email is required');
                    isValid = false;
                } else if (!isValidEmail(email.value)) {
                    showError(email, 'emailAddressError', 'Please enter a valid email address');
                    errorMessages.push('Please enter a valid email address');
                    isValid = false;
                }
                
                // Password validation
                if (password.value.trim() === '') {
                    showError(password, 'passwordError', 'Password is required');
                    errorMessages.push('Password is required');
                    isValid = false;
                } else if (password.value.length < 8) {
                    showError(password, 'passwordError', 'Password must be at least 8 characters');
                    errorMessages.push('Password must be at least 8 characters');
                    isValid = false;
                }
                
                // Confirm Password validation
                if (confirmPassword.value.trim() === '') {
                    showError(confirmPassword, 'confirmPasswordError', 'Please confirm your password');
                    errorMessages.push('Please confirm your password');
                    isValid = false;
                } else if (password.value !== confirmPassword.value) {
                    showError(confirmPassword, 'confirmPasswordError', 'Passwords do not match');
                    errorMessages.push('Passwords do not match');
                    isValid = false;
                }
                
                // Phone Number validation
                if (phoneNumber.value.trim() === '') {
                    showError(phoneNumber, 'phoneNumberError', 'Phone number is required');
                    errorMessages.push('Phone number is required');
                    isValid = false;
                } else if (!isValidPhoneNumber(phoneNumber.value)) {
                    showError(phoneNumber, 'phoneNumberError', 'Please enter a valid phone number');
                    errorMessages.push('Please enter a valid phone number');
                    isValid = false;
                }
                
                // Website validation (optional)
                if (website.value.trim() !== '' && !isValidUrl(website.value)) {
                    showError(website, 'websiteError', 'Please enter a valid website URL');
                    errorMessages.push('Please enter a valid website URL');
                    isValid = false;
                }
                
                // Industry validation
                if (industry.value.trim() === '') {
                    showError(industry, 'industryError', 'Industry is required');
                    errorMessages.push('Industry is required');
                    isValid = false;
                }
                
                // Location validation
                if (location.value.trim() === '') {
                    showError(location, 'locationError', 'Location is required');
                    errorMessages.push('Location is required');
                    isValid = false;
                }
                
                // Logo validation (optional)
                if (logoUpload.value !== '') {
                    const validExtensions = ['jpg', 'jpeg', 'png'];
                    const fileExtension = logoUpload.value.split('.').pop().toLowerCase();
                    
                    if (!validExtensions.includes(fileExtension)) {
                        showError(logoUpload, 'logoUploadError', 'Only JPG, JPEG, and PNG files are allowed');
                        errorMessages.push('Only JPG, JPEG, and PNG files are allowed');
                        isValid = false;
                    }
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
                    
                    return false;
                }
                
                return true;
            } catch (e) {
                //console.error("Validation error:", e);
                //alert("An error occurred during validation. Please check the form.");
                return false;
            }
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
            if (errorSummary) {
                errorSummary.style.display = 'none';
                errorSummary.innerHTML = '';
            }
        }

        function showError(inputElement, errorSpanId, message) {
            // Highlight the input field
            inputElement.classList.add('input-error');

            // Show the error message
            const errorSpan = document.getElementById(errorSpanId);
            if (errorSpan) {
                errorSpan.innerText = message;
                errorSpan.style.display = 'block';
            }
        }

        function isValidEmail(email) {
            const re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            return re.test(email);
        }

        function isValidPhoneNumber(phone) {
            const re = /^[0-9]{8,15}$/;
            return re.test(phone);
        }

        function isValidUrl(url) {
            try {
                new URL(url);
                return true;
            } catch (e) {
                return false;
            }
        }

        document.getElementById('<%= ddlSecurityQuestion.ClientID %>').addEventListener('change', function () {
            const customGroup = document.getElementById('customQuestionGroup');
            if (this.value === 'custom') {
                customGroup.style.display = 'block';
            } else {
                customGroup.style.display = 'none';
            }
        });
    </script>
</body>
</html>