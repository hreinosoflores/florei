import React from 'react';
import ProductoArticle from '../components/article/ProductoArticle';
import axios from 'axios';
import { sortProductossxNombreAsc } from '../Global';
import PropTypes from "prop-types";
import { useParams } from 'react-router-dom';

function ProductosXDesc() {

    const [productos, setProductos] = React.useState([]);

    const { descripcion } = useParams();

    const titulo = 'Búsqueda de productos con \'' + descripcion + '\'';

    React.useEffect(() => {

        document.title = `${titulo} ${import.meta.env.VITE_TITLE_SUFFIX}`;

        async function fetchData() {
            try {
                const response = await axios({
                    method: 'GET',
                    url: `${import.meta.env.VITE_URL_API}producto`
                });

                setProductos(response.data.resultado.filter(prod => prod.auditoria.activo));

            } catch (error) {
                console.error(error);
            }
        }

        fetchData();

    }, [titulo]);

    return (
        <section>
            <h1 className="proxsubcat-titulo">{titulo}</h1>
            <section className="grilla">
                {
                    productos
                        .filter(
                            producto =>
                                producto.descripcion.toUpperCase()
                                    .includes(descripcion.toUpperCase()))
                        .sort(sortProductossxNombreAsc)
                        .map(
                            producto =>
                                <ProductoArticle
                                    key={producto.id + "-desc"}
                                    producto={producto}
                                    subcat={{ categoria: { id: 0 } }} />
                        )
                }
            </section>
        </section>
    )
}

export default ProductosXDesc;



ProductosXDesc.propTypes = { match: PropTypes.any };