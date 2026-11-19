import React from 'react';
import ProductoArticle from '../components/article/ProductoArticle';
import axios from 'axios';
import { sortProductossxNombreAsc } from '../Global';
import { useParams } from 'react-router-dom';

function ProductosXSubCat() {

    const [subcat, setSubcat] = React.useState(
        {
            "id": null,
            "categoria": {
                "id": null,
                "descripcion": null,
                "imagen": {
                    "id": null,
                    "nombreExt": null,
                    "idGoogleDrive": null
                }
            },
            "descripcion": null,
            "slug": null,
            "imagen": {
                "id": null,
                "nombreExt": null,
                "idGoogleDrive": null
            }
        }
    );


    const [productos, setProductos] = React.useState([]);


    const { subcat: sub } = useParams();

    React.useEffect(() => {

        async function fetchData() {
            try {
                const response = await axios({
                    method: 'GET',
                    url: `${import.meta.env.VITE_URL_API}subcategoria`
                });

                setSubcat(response.data.resultado
                    .find(subcat => subcat.slug === sub)
                );

            } catch (error) {
                console.error(error);
            }
        }

        fetchData();

    }, [sub]);


    React.useEffect(() => {

        document.title = `${subcat.descripcion} ${import.meta.env.VITE_TITLE_SUFFIX}`;

        async function fetchData() {
            try {
                const response = await axios({
                    method: 'GET',
                    url: `${import.meta.env.VITE_URL_API}producto`
                });

                setProductos(response.data.resultado
                    .filter(prod =>
                        prod.auditoria.activo &&
                        prod.subCategoria.id === subcat.id
                    )
                );

            } catch (error) {
                console.error(error);
            }
        }

        fetchData();

    }, [subcat.descripcion, subcat.id]);

    return (
        <section>
            <h1 className="proxsubcat-titulo">{subcat.descripcion}</h1>
            <section className="grilla">
                {
                    productos
                        .sort(sortProductossxNombreAsc)
                        .map(producto =>
                            <ProductoArticle
                                key={producto.id + "-subcat"}
                                producto={producto}
                                subcat={subcat} />
                        )
                }
            </section>
        </section>
    )
}

export default ProductosXSubCat;


