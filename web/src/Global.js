export const sortSubcatsxNombreAsc = (s1, s2) => {
    if (s1.descripcion > s2.descripcion) return 1;
    if (s1.descripcion < s2.descripcion) return -1;
    return 0;
}

export const sortProductossxNombreAsc = (p1, p2) => {
    if (p1.descripcion > p2.descripcion) return 1;
    if (p1.descripcion < p2.descripcion) return -1;
    return 0;
}


export const transformUrlCloudinary = (urlInicial) => {
    let position = urlInicial.indexOf("/v");
    let urlTransform = urlInicial.substring(0, position + 1) +
        import.meta.env.VITE_TRANSFORM_CLOUDINARY +
        urlInicial.substring(position);
    return urlTransform;
}
