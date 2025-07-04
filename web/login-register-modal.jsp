<div id="signupModal" class="modal-overlay" style="display:${requestScope.openSignupModalOnLoad ? 'block' : 'none'};">
    <div class="modal-content">
        <span class="close-btn" id="closeSignupModal">&times;</span>
        <div class="account-container">
            <div class="heading-bx left text-center">
                <h2 class="title-head">Sign Up <span>Now</span></h2>
                <p>Already have an account? <a href="" onclick="switchToLogin()">Click here</a></p>
            </div>

            <form class="contact-bx" action="loginregistercontroller?action=signup" method="post">
                <%-- HI?N TH? TH�NG B�O L?I ??NG K� --%>
                <c:if test="${not empty requestScope.signupError}">
                    <div id="signupErrorMessageDiv" style="color: red; margin-bottom: 15px; text-align: center;">
                        ${requestScope.signupError}
                    </div>
                </c:if>

                <%-- M?I: HI?N TH? TH�NG B�O ??NG K� TH�NH C�NG --%>
                <c:if test="${not empty requestScope.signupSuccessMessage}">
                    <div id="signupSuccessMessageDiv" style="color: graytext; margin-bottom: 15px; text-align: center;">
                        ${requestScope.signupSuccessMessage}
                    </div>
                </c:if>


                <div class="form-group">
                    <label>Full Name</label>
                    <input name="fullName" type="text" required class="form-control" 
                           value="${requestScope.prevFullName != null ? requestScope.prevFullName : ''}">
                </div>
                <div class="form-group">
                    <label>Gender</label><br />
                    <label class="m-r10">
                        <input type="radio" name="gender" value="Male" required 
                               ${requestScope.prevGender == 'Male' ? 'checked' : ''}> Male
                    </label>
                    <label>
                        <input type="radio" name="gender" value="Female" 
                               ${requestScope.prevGender == 'Female' ? 'checked' : ''}> Female
                    </label>
                    <label>
                        <input type="radio" name="gender" value="Other" 
                               ${requestScope.prevGender == 'Other' ? 'checked' : ''}> Other
                    </label>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input name="email" type="email" required class="form-control" 
                           value="${requestScope.prevEmail != null ? requestScope.prevEmail : ''}">
                </div>
                <div class="form-group">
                    <label>Mobile</label>
                    <input name="mobile" type="text" class="form-control" <%-- Mobile kh�ng y�u c?u required trong form c?a b?n --%>
                           value="${requestScope.prevMobile != null ? requestScope.prevMobile : ''}">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input name="password" type="password" required class="form-control">
                </div>

                <button type="submit" class="btn button-md">Sign Up</button>

                <div class="social-login text-center mt-3">
                    <h6>Or Sign Up with Social Media</h6>
                    <a class="btn google-plus" href="#"><i class="fa fa-google-plus"></i> Google</a>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="loginModal" class="modal-overlay" style="display:none;">
    <div class="modal-content">
        <span class="close-btn" id="closeLoginModal">&times;</span>
        <div class="account-container">
            <div class="heading-bx left text-center">
                <h2 class="title-head">Login to your <span>Account</span></h2>
                <p>Don't have an account? <a href="#" onclick="event.preventDefault(); switchToSignup();">Create one here</a></p>
            </div>
            
            

            <form class="contact-bx" action="loginregistercontroller?action=login" method="post">
                <div id="loginErrorMessageDiv" style="color: red; margin-bottom: 15px; text-align: center;"></div>

                <div class="form-group">
                    <label>Email</label>
                    <input name="email" type="text" required class="form-control" value="${prevEmail != null ? prevEmail : ''}">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input name="password" type="password" required class="form-control">
                </div>
                <div class="form-group d-flex justify-content-between align-items-center">
                    <a href="forget-password.jsp" class="text-right" style="font-size: 14px;">Forgot Password?</a>
                </div>
                <button type="submit" class="btn button-md">Login</button>

                <div class="social-login text-center mt-3">
                    <h6>Login with Social media</h6>
                    <a class="btn google-plus" href="#"><i class="fa fa-google-plus"></i> Google</a>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
    /* ??m b?o c�c ki?u CSS n�y n?m trong th? <style> c?a b?n */
    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.6);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 9999;
    }
    .modal-content {
        background: white;
        padding: 30px;
        border-radius: 10px;
        width: 100%;
        max-width: 500px;
        position: relative;
    }
    .close-btn {
        position: absolute;
        top: 10px;
        right: 15px;
        font-size: 22px;
        font-weight: bold;
        color: #999;
        cursor: pointer;
    }
    .close-btn:hover {
        color: #000;
    }

    .account-container {
        background: #ffffff;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        padding: 30px;
        max-width: 500px;
        width: 100%;
    }
    .heading-bx h2 {
        font-size: 30px;
        font-weight: bold;
        margin-bottom: 10px;
    }
    .heading-bx p {
        margin-bottom: 20px;
        font-size: 14px;
    }
    .form-group {
        margin-bottom: 20px;
    }
    label {
        font-weight: 600;
        color: #333;
    }
    .form-control {
        width: 100%;
        padding: 10px 15px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 15px;
    }
    .form-control:focus {
        border-color: #0d6efd;
        outline: none;
    }
    .btn.button-md {
        background-color: #0d6efd;
        color: white;
        border: none;
        padding: 12px;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        width: 100%;
        transition: background-color 0.3s ease;
    }
    .btn.button-md:hover {
        background-color: #0b5ed7;
    }
    .google-plus {
        display: inline-block;
        margin-top: 10px;
        background-color: #db4437;
        color: white;
        padding: 10px 20px;
        border-radius: 6px;
        text-decoration: none;
    }
    .google-plus:hover {
        background-color: #c23321;
    }
</style>

<script>
    window.onload = function () {
        // --- Logic ?? m? Modal ??ng nh?p khi c� l?i t? Server ---
        // JSP Scriptlet ?? ki?m tra request attributes ???c ??t b?i Servlet
    <%
            Boolean openLoginModalOnLoad = (Boolean) request.getAttribute("openLoginModalOnLoad");
            String loginErrorMessage = (String) request.getAttribute("loginError");
            String prevEmail = (String) request.getAttribute("prevEmail");
    %>

        // JavaScript code s? ch?y d?a tr�n gi� tr? t? JSP Scriptlet
        if (<%= openLoginModalOnLoad != null && openLoginModalOnLoad %>) {
            document.getElementById("loginModal").style.display = "flex"; // M? modal ??ng nh?p

            // Hi?n th? th�ng b�o l?i
            const errorMessageDiv = document.getElementById("loginErrorMessageDiv");
            if (errorMessageDiv) {
                errorMessageDiv.innerText = "<%= loginErrorMessage != null ? loginErrorMessage : "" %>";
            }

            // ?i?n l?i email ?� nh?p tr??c ?�
            const emailInput = document.querySelector('#loginModal input[name="email"]');
            if (emailInput) {
                emailInput.value = "<%= prevEmail != null ? prevEmail : "" %>";
            }
        }

        // --- Logic ?? m? Modal ??ng k� khi c� l?i t? Server (n?u b?n x? l� ??ng k� trong c�ng controller) ---
    <%
            Boolean openSignupModalOnLoad = (Boolean) request.getAttribute("openSignupModalOnLoad");
            String signupErrorMessage = (String) request.getAttribute("signupError");
            String prevSignupFullName = (String) request.getAttribute("prevFullName");
            String prevSignupEmail = (String) request.getAttribute("prevEmail");
    %>

        if (<%= openSignupModalOnLoad != null && openSignupModalOnLoad %>) {
            document.getElementById("signupModal").style.display = "flex"; // M? modal ??ng k�

            const signupErrorDiv = document.getElementById("signupErrorMessageDiv");
            if (signupErrorDiv) {
                signupErrorDiv.innerText = "<%= signupErrorMessage != null ? signupErrorMessage : "" %>";
            }

            const signupFullNameInput = document.querySelector('#signupModal input[name="fullName"]');
            if (signupFullNameInput) {
                signupFullNameInput.value = "<%= prevSignupFullName != null ? prevSignupFullName : "" %>";
            }
            const signupEmailInput = document.querySelector('#signupModal input[name="email"]');
            if (signupEmailInput) {
                signupEmailInput.value = "<%= prevSignupEmail != null ? prevSignupEmail : "" %>";
            }
        }


        // --- Logic x? l� th�ng b�o th�nh c�ng t? URL (v� d?: sau khi ??ng k� th�nh c�ng) ---
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('signup') === 'success') {
            alert('??ng k� t�i kho?n th�nh c�ng! Vui l�ng ??ng nh?p.');
            document.getElementById("loginModal").style.display = "flex"; // M? modal ??ng nh?p
            // X�a tham s? kh?i URL ?? th�ng b�o kh�ng hi?n l?i khi refresh trang
            history.replaceState({}, document.title, window.location.pathname);
        }
    };

    // --- C�c h�m JavaScript hi?n c� c?a b?n ?? m?/?�ng modal v� chuy?n ??i gi?a ch�ng ---
    document.getElementById("openSignupModal").onclick = () => {
        document.getElementById("signupModal").style.display = "flex";
        // Khi m?, ??m b?o ?n th�ng b�o l?i c?
        const signupErrorDiv = document.getElementById("signupErrorMessageDiv");
        if (signupErrorDiv)
            signupErrorDiv.innerText = "";
    };
    document.getElementById("openLoginModal").onclick = () => {
        document.getElementById("loginModal").style.display = "flex";
        // Khi m?, ??m b?o ?n th�ng b�o l?i c?
        const errorMessageDiv = document.getElementById("loginErrorMessageDiv");
        if (errorMessageDiv)
            errorMessageDiv.innerText = "";
    };
    document.getElementById("closeSignupModal").onclick = () => {
        document.getElementById("signupModal").style.display = "none";
    };
    document.getElementById("closeLoginModal").onclick = () => {
        document.getElementById("loginModal").style.display = "none";
    };

    function switchToSignup() {
        document.getElementById("loginModal").style.display = "none";
        document.getElementById("signupModal").style.display = "flex";
        // Khi chuy?n, ??m b?o ?n th�ng b�o l?i c?
        const signupErrorDiv = document.getElementById("signupErrorMessageDiv");
        if (signupErrorDiv)
            signupErrorDiv.innerText = "";
        const errorMessageDiv = document.getElementById("loginErrorMessageDiv");
        if (errorMessageDiv)
            errorMessageDiv.innerText = "";
    }
    function switchToLogin() {
        document.getElementById("signupModal").style.display = "none";
        document.getElementById("loginModal").style.display = "flex";
        // Khi chuy?n, ??m b?o ?n th�ng b�o l?i c?
        const signupErrorDiv = document.getElementById("signupErrorMessageDiv");
        if (signupErrorDiv)
            signupErrorDiv.innerText = "";
        const errorMessageDiv = document.getElementById("loginErrorMessageDiv");
        if (errorMessageDiv)
            errorMessageDiv.innerText = "";
    }

    // ?�ng modal khi click ra ngo�i overlay
    window.onclick = (e) => {
        if (e.target === document.getElementById("signupModal"))
            document.getElementById("signupModal").style.display = "none";
        if (e.target === document.getElementById("loginModal"))
            document.getElementById("loginModal").style.display = "none";
    };
</script>