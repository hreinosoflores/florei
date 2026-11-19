import React from 'react';
import no_disponible from '../../img/img_no_disponible.png';
import agotado from '../../img/agotado.png';
import ProductoTbody from '../tbody/ProductoTbody';
import LuzTbody from '../tbody/LuzTbody';
import { transformUrlCloudinary } from '../../Global';
import PropTypes from "prop-types";

function ProductoArticle({ producto, subcat }) {

    const infoExtra = () => {
        switch (subcat.categoria.id) {
            case 1:
                return <LuzTbody key={producto.id + "-luz"} idProd={producto.id} />;
            default:
                return null;
        }
    }

    return (
        <article className="producto-card">
            <img
                src={
                    producto.stockActual === 0 ?
                        agotado :
                        producto.imagen == null ?
                            no_disponible :
                            `${transformUrlCloudinary(producto.imagen.secureUrlCloudinary)}`
                }
                alt={
                    producto.imagen == null ?
                        'imagen no disponible' :
                        producto.imagen.nombreExt
                }
                className="rounded-t-xl" />
            <h2 className="producto-card-titulo">{producto.descripcion}</h2>
            <table className="bg-dorado w-full rounded-b-xl">
                <ProductoTbody key={producto.id + "-prod"} producto={producto} />
                {infoExtra()}
            </table>
        </article>
    )
}

export default ProductoArticle;


ProductoArticle.propTypes = { producto: PropTypes.any.isRequired };
ProductoArticle.propTypes = { subcat: PropTypes.any.isRequired };