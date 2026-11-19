/** @type {import("tailwindcss").Config} */
export default {
    content: ["./src/**/*.{html,js,jsx}", "./index.html"],
    theme: {
        extend: {
            colors: {
                "verde-limo": "#8CDF06",
                "blanco": "#FFFFFF",
                "dorado": "#ffb944",
                "gris-claro": "#f5f5f5",
                "verde-bosque": "#014421",
                "naranja-oscuro": "#FF4000",
                "negro": "#1a1a1a",
                "rojo": "#FF0000",
            },
        },
    },
    plugins: [],
}

