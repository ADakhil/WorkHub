<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Create-an-Account-Seeker.aspx.cs" Inherits="workHub.Create_an_Account_Seeker" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Seeker Account - WorkHub</title>
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
    .phone-input {
      display: flex;
      gap: 10px;
    }
    .phone-input select {
      width: 80px;
    }
    .phone-input input {
      flex: 1;
    }
    .container{
        display:flex;
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
  <form id="form1" runat="server" onsubmit="return validateForm()">
    <div class="container">
      <div class="left-section">
          <a class="back-btn" href="HomePageF.aspx">Go Back</a>
        <h1>Welcome to WorkHub Platform</h1>
        <p>Join Work Hub Today. Empower Your Career with WorkHub.
          Create your account to discover job opportunities tailored to your skills, build a standout profile, and track your
          applications seamlessly—all in one platform. Elevate your job search experience and take a step closer to your dream
          job effortlessly.</p>
      </div>
      <div class="right-section">
        <h2>Create Seeker Account</h2>
        
        <asp:Label ID="errorSummary" runat="server" CssClass="error-message" ClientIDMode="Static"></asp:Label>

        <div class="form-group">
          <label for="txtName">Full Name *</label>
          <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your full legal name" ClientIDMode="Static" />
          <span id="nameError" class="error-message" runat="server"></span>
        </div>

        <div class="form-group">
          <label for="txtEmail">Email Address *</label>
          <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Your email address" ClientIDMode="Static" />
          <span id="emailError" class="error-message" runat="server"></span>
        </div>

        <div class="form-group">
          <label for="txtPassword">Password *</label>
          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Create a strong password" ClientIDMode="Static" />
          <span id="passwordError" class="error-message" runat="server"></span>
        </div>

        <div class="form-group">
          <label for="txtConfirmPassword">Confirm Password *</label>
          <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Re-enter your password" ClientIDMode="Static" />
          <span id="confirmPasswordError" class="error-message" runat="server"></span>
        </div>

        <div class="form-group">
          <label for="txtPhone">Phone Number *</label>
          <div class="phone-input">
            <asp:DropDownList ID="ddlPhoneCode" runat="server" CssClass="form-control" ClientIDMode="Static">
              <asp:ListItem Text="+966" Value="+966" />
              <asp:ListItem Text="+92" Value="+92" />
              <asp:ListItem Text="+1" Value="+1" />
            </asp:DropDownList>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone number" ClientIDMode="Static" />
          </div>
          <span id="phoneError" class="error-message" runat="server"></span>
        </div>

        <div class="form-group">
          <label for="txtLocation">Location *</label>
          <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="Your city and country" ClientIDMode="Static" />
          <span id="locationError" class="error-message" runat="server"></span>
        </div>

        <div class="form-group">
          <label for="fuCV">CV (Optional)</label>
          <asp:FileUpload ID="fuCV" runat="server" CssClass="form-control" ClientIDMode="Static" />
          <span id="cvError" class="error-message" runat="server"></span>
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

        <div class="login-link">
          Already have an account? <a href="Login-Seekr.aspx">Log in</a>
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
              const name = document.getElementById('<%= txtName.ClientID %>');
              const email = document.getElementById('<%= txtEmail.ClientID %>');
              const password = document.getElementById('<%= txtPassword.ClientID %>');
              const confirmPassword = document.getElementById('<%= txtConfirmPassword.ClientID %>');
              const phone = document.getElementById('<%= txtPhone.ClientID %>');
              const location = document.getElementById('<%= txtLocation.ClientID %>');
              const cvUpload = document.getElementById('<%= fuCV.ClientID %>');
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
              
              // Name validation
              if (name.value.trim() === '') {
                  showError(name, 'nameError', 'Full name is required');
                  errorMessages.push('Full name is required');
                  isValid = false;
              }
              
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
              
              // Phone validation
              if (phone.value.trim() === '') {
                  showError(phone, 'phoneError', 'Phone number is required');
                  errorMessages.push('Phone number is required');
                  isValid = false;
              } else if (!isValidPhoneNumber(phone.value)) {
                  showError(phone, 'phoneError', 'Please enter a valid phone number');
                  errorMessages.push('Please enter a valid phone number');
                  isValid = false;
              }
              
              // Location validation
              if (location.value.trim() === '') {
                  showError(location, 'locationError', 'Location is required');
                  errorMessages.push('Location is required');
                  isValid = false;
              }
              
              // CV validation (optional)
              if (cvUpload.value !== '') {
                  const validExtensions = ['pdf', 'doc', 'docx'];
                  const fileExtension = cvUpload.value.split('.').pop().toLowerCase();
                  
                  if (!validExtensions.includes(fileExtension)) {
                      showError(cvUpload, 'cvError', 'Only PDF, DOC, and DOCX files are allowed');
                      errorMessages.push('Only PDF, DOC, and DOCX files are allowed');
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