import React from 'react';
import no_disponible from '../../img/img_no_disponible.png';
import { Link } from 'react-router-dom';
import { transformUrlCloudinary } from '../../Global';
import PropTypes from "prop-types";

function SubCatArticle({ subcat }) {

    return (
        <article className="subcat-card">
            <Link to={`/categorias/${subcat.slug}`}>
                {/* <img
                src={subcat.imagen == null ? no_disponible : `${import.meta.env.VITE_URL_GDRIVE}${subcat.imagen.idGoogleDrive}`}
                alt={subcat.imagen == null ? 'imagen no disponible' : subcat.imagen.nombreExt}
                className="rounded-t-xl" /> */}
                <img
                    src={subcat.imagen == null ? no_disponible : `${transformUrlCloudinary(subcat.imagen.secureUrlCloudinary)}`}
                    alt={subcat.imagen == null ? 'imagen no disponible' : subcat.imagen.nombreExt}
                    className="rounded-t-xl" />
                <h2 className="subcat-card-titulo">{subcat.descripcion}</h2>
            </Link>
        </article>
    )
}

export default SubCatArticle;

SubCatArticle.propTypes = { subcat: PropTypes.any.isRequired };