setNav =  () ->
  $(document).ready ->
    location = window.location.pathname
    if location is "/curriculum"
      $("#overviewCrumb").addClass "current"
    if location isnt "/curriculum" && location.match "/curriculum"
      $("#curriculumCrumb").text document.title
      $("#curriculumCrumb").removeClass "hidden"
setNav()
