import React from 'react';
import axios from 'axios';
import PropTypes from "prop-types";

function ProductoTbody({ producto }) {

    const [precio, setPrecio] = React.useState();

    const componentMounted = React.useRef(true); //component is mounted

    React.useEffect(() => {

        async function fetchData() {
            try {
                const response = await axios({
                    method: 'GET',
                    url: `${import.meta.env.VITE_URL_API}precioxgrupo`
                });

                const aux = response.data.resultado
                    .find(prexgru =>
                        prexgru.auditoria.activo &&
                        prexgru.producto.id === producto.id &&
                        prexgru.grupoVenta.id === 1
                    );

                if (componentMounted.current) { // is component still mounted?
                    if (aux != null) {
                        setPrecio("S/. " + aux.valorSoles.toFixed(2));
                    } else {
                        setPrecio(import.meta.env.VITE_SINDATOS);
                    }
                }
            } catch (error) {
                console.error(error);
            }
        }

        fetchData();

        // return () => { // This code runs when component is unmounted
        //     componentMounted.current = false; //set it to false when we leave the page
        // }

    }, [producto.id]);


    return (
        <tbody >
            <tr>
                <td className="producto-td">Categoría</td>
                <td className="producto-td">{producto.subCategoria.descripcion}</td>
            </tr>
            <tr>
                <td className="producto-td">Marca</td>
                <td className="producto-td">{
                    producto.marca == null ?
                        import.meta.env.VITE_SINDATOS :
                        producto.marca.descripcion
                }</td>
            </tr>
            <tr>
                <td className="producto-td">Precio Unidad</td>
                <td className="producto-td font-bold">{precio}</td>
            </tr>
            <tr>
                <td className="producto-td">Cantidad x Caja</td>
                <td className="producto-td">{
                    producto.cantidadxCaja == null || producto.cantidadxCaja === 0 ?
                        import.meta.env.VITE_SINDATOS :
                        producto.cantidadxCaja === 1 ?
                            `${producto.cantidadxCaja} unidad` :
                            `${producto.cantidadxCaja} unidades`
                }</td>
            </tr>
            <tr>
                <td className="producto-td">Garantía</td>
                <td className="producto-td">{
                    producto.garantia == null || producto.garantia === 0 ?
                        import.meta.env.VITE_SINDATOS :
                        producto.garantia / 12 === 1 ?
                            "1 año" :
                            producto.garantia % 12 === 0 ?
                                `${producto.garantia / 12} años` :
                                `${producto.garantia} meses`

                }</td>
            </tr>
        </tbody>
    )
}

export default ProductoTbody;


ProductoTbody.propTypes = { producto: PropTypes.any.isRequired };
