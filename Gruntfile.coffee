module.exports = (grunt) ->

  grunt.initConfig
    pkg:
      grunt.file.readJSON 'package.json'

    coffee:
      app:
        options:
          join: true
        files:
          'scripts/app.js': ['app/scripts/**/*.coffee']

    concat:
      coffee:
        src: ['app/scripts/**/*.coffee']
        dest: 'scripts/app.js'
      css:
        src: 'styles/*.css'
        dest: 'styles/app.css'

    sass:
      dist:
        options:
          sourcemap: 'none'
          files: [
           expand: true
           cwd: 'app/styles'
           src: ['app.scss']
           dest: 'styles'
           ext: '.css'
          ]

    cssmin:
      dist:
        files: [
          expand: true
          cwd: 'styles'
          src: ['*.css', '!*.min.css']
          dest: 'styles'
          ext: '.min.css'
        ]

    clean:
      build:
        src: ['scripts/*.js', '!scripts/*.min.js', 'styles/*.css', '!styles/*.min.css']

    watch:
      coffee:
        files: ['app/scripts/**/*.coffee']
        tasks: ['coffee:app']

      sass:
        files: ['app/styles/**/*.scss']
        tasks: ['sass']

  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'default', ['coffee:app', 'sass', 'concat:coffee', 'watch']
  grunt.registerTask 'build', ['coffee:app', 'sass', 'cssmin:dist', 'concat:coffee']
