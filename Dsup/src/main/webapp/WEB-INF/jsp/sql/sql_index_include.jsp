<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="${pageContext.request.contextPath }/resources/js/sql/go/release/go.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/go/extensions/Figures.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/build.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/controller.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/dto.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/process.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/storage.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/display.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/setting.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/common.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sql/command.js"></script>
<style>
.error { width: auto; height: 20px; height:auto; position: fixed; left: 50%; margin-left:-125px; bottom: 100px; z-index: 9999; background-color: #383838; color: #F0F0F0; font-family: Calibri; font-size: 15px; padding: 10px; text-align:center; border-radius: 2px; -webkit-box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1); -moz-box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1); box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1); }
</style>
<script>
$(function(){
	$('#myPaletteDiv div').css('display', 'none');
});
</script>
<style>
  .bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
  }

  @media (min-width: 768px) {
    .bd-placeholder-img-lg {
      font-size: 3.5rem;
    }
  }
</style>

<style>
body {
  font-size: .875rem;
}

.feather {
  width: 16px;
  height: 16px;
  vertical-align: text-bottom;
}

/*
 * Sidebar
 */

.sidebar {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  z-index: 100; /* Behind the navbar */
  padding: 48px 0 0; /* Height of navbar */
  box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
}

.sidebar-sticky {
  position: relative;
  top: 0;
  height: calc(100vh - 48px);
  padding-top: .5rem;
  overflow-x: hidden;
  overflow-y: auto; /* Scrollable contents if viewport is shorter than content. */
}

@supports ((position: -webkit-sticky) or (position: sticky)) {
  .sidebar-sticky {
    position: -webkit-sticky;
    position: sticky;
  }
}

.sidebar .nav-link {
  font-weight: 500;
  color: #333;
}

.sidebar .nav-link .feather {
  margin-right: 4px;
  color: #999;
}

.sidebar .nav-link.active {
  color: #007bff;
}

.sidebar .nav-link:hover .feather,
.sidebar .nav-link.active .feather {
  color: inherit;
}

.sidebar-heading {
  font-size: .75rem;
  text-transform: uppercase;
}

/*
 * Content
 */

[role="main"] {
  padding-top: 133px; /* Space for fixed navbar */
}

@media (min-width: 768px) {
  [role="main"] {
    padding-top: 48px; /* Space for fixed navbar */
  }
}

/*
 * Navbar
 */

.navbar-brand {
  padding-top: .75rem;
  padding-bottom: .75rem;
  font-size: 1rem;
  background-color: rgba(0, 0, 0, .25);
  box-shadow: inset -1px 0 0 rgba(0, 0, 0, .25);
}

.navbar .form-control {
  padding: .75rem 1rem;
  border-width: 0;
  border-radius: 0;
}

.form-control-dark {
  color: #fff;
  background-color: rgba(255, 255, 255, .1);
  border-color: rgba(255, 255, 255, .1);
}

.form-control-dark:focus {
  border-color: transparent;
  box-shadow: 0 0 0 3px rgba(255, 255, 255, .25);
}
</style>
