module.exports = {
    mode: "jit",
    content: ["./js/**/*.js", 
              "../lib/*_web.ex",
              "../lib/*_web/**/*.*ex"],
    theme: {
      extend: {},
    },
    plugins: [
      require('@tailwindcss/forms')
    ],
  };
  