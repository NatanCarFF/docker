* {
    /*Background parte externa*/
    --login-bg-glpi: url(https://github.com/RafilskMTx/pics/blob/main/BG.png?raw=true);

    /*Logo parte externa*/
    #--login-logo-glpi: url(https://github.com/RafilskMTx/pics/blob/main/LOGO%20200x70.png?raw=true);

    /*Logo parte interna*/
    --bar-logo-glpi: url(https://github.com/RafilskMTx/pics/blob/main/LOGO%20200x70.png?raw=true);

    /*Logo parte interna c/ menu recolhido*/
    --bar-logo-glpi-collapsed: url(https://github.com/RafilskMTx/pics/blob/main/LOGO%20200x70.png?raw=true);

    /*cor primaria*/
    --main-primary-color: #000;
    --main-primary-color-hover: #f60;
    --main-primary-color-text: #fff;

    /*cor secundaria*/
    --main-secondary-color: #f60;
    --main-secondary-color-hover: #f60;
    --main-secondary-color-text: #fff;

    /*cor para destaque*/
    --main-detach-color: #f60;
    --main-counter-color: #000;
}

.welcome-anonymous {
    /*background tela login*/
    background: var(--login-bg-glpi) no-repeat;
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
}

.page-anonymous .glpi-logo {
    /*logo externo*/
    --logo: var(--login-logo-glpi);
    content: var(--login-logo-glpi);
    width: 22em;
    height: 179px;
}

.page .glpi-logo {
    /*logo menu lateral ou superior*/
    background: var(--bar-logo-glpi) no-repeat;
    background-position-x: center;
    background-size: contain;
    height: 115px;
    width: 200px;
}

.welcome-anonymous .card {
    /*cor card login*/
    --tblr-card-border-radius: 20px;
    box-shadow: rgba(30, 41, 59, 0.04) 0 2px 4px 0;
    border: 1px solid rgba(98, 105, 118, 0.16);
    background: #000c;
    color: #fff;
    border-radius: var(--tblr-card-border-radius);
    transition: transform 0.3s ease-out, opacity 0.3s ease-out, box-shadow 0.3s ease-out;
    width: 38rem;
    margin-left: 10rem;
    margin-top: 15rem;
    
}

body.navbar-collapsed .navbar-brand .glpi-logo {
    /*logo menu recolhido*/
    background: var(--bar-logo-glpi-collapsed) no-repeat;
    background-size: contain;
    width: 75px;
    height: 75px;
}

.sidebar,
.topbar {
    /*cor menu lateral ou superior*/
    background-color: var(--main-primary-color);
    color: #fff;
    z-index: 1030;
}

.btn-primary,
.btn-outline-primary,
.btn-ghost-primary {
    /*botões primarios*/
    --tblr-btn-color: var(--main-primary-color);
    --tblr-btn-color-interactive: var(--main-primary-color-hover);
    --tblr-btn-color-text: var(--main-primary-color-text);
    border: none;
}

.btn-secondary,
.btn-outline-secondary,
.btn-ghost-secondary {
    /*botões secundarios*/
    --tblr-btn-color: var(--main-secondary-color);
    --tblr-btn-color-interactive: var(--main-secondary-color-hover);
    --tblr-btn-color-text: var(--main-secondary-color-text);
}

.card-tabs #tabspanel.nav-tabs .nav-link .badge {
    /*contadores*/
    margin-left: 5px;
    background-color: var(--main-counter-color);
    color: var(--main-detach-color);
}


.sidebar #navbar-menu .nav-item .nav-link.show,
.sidebar #navbar-menu .nav-item .nav-link.active {
    /*nav bar primario ativado*/
    border-left-color: var(--main-secondary-color);
    color: var(--main-secondary-color);
    font-weight: bold;
}

.sidebar #navbar-menu .nav-item .nav-link:hover {
    /*nav bar primario hover*/
    border-left-color: var(--main-secondary-color);
    color: var(--main-secondary-color);
    font-weight: bold;
}

.sidebar #navbar-menu .nav-item .nav-link.active+.dropdown-menu .dropdown-item:hover,
.sidebar #navbar-menu .nav-item .nav-link.show+.dropdown-menu .dropdown-item:hover {
    /*nav bar secundario ativado*/
    border-left-color: var(--main-secondary-color);
    color: var(--main-secondary-color);
    background-color: rgba(0, 0, 0, 0.2);
}

.sidebar #navbar-menu .nav-item .nav-link.active+.dropdown-menu .dropdown-item:hover,
.sidebar #navbar-menu .nav-item .nav-link.show+.dropdown-menu .dropdown-item.active {
    /*nav bar secundario ativado*/
    border-left-color: var(--main-secondary-color);
    color: var(--main-secondary-color);
    background-color: rgba(0, 0, 0, 0.2);
}

body.navbar-collapsed .sidebar #navbar-menu .nav-item.active {
    /*cor ativo recolhido*/
    background-color: var(--main-primary-color);
}

.copyright {
    /*cor link copyright*/
    color: #f5f7f3;
}

.welcome-anonymous .form-control{
    /*cor letra imput externo*/
    color: #000;
}
