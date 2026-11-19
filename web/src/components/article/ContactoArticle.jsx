import React from 'react';
import { FaPhoneAlt } from "react-icons/fa";
import { FiMail } from "react-icons/fi";
import PropTypes from "prop-types";

function ContactoArticle(props) {

    const row = (arr) => {
        let jsx = null;
        let icono =
            JSON.stringify(arr) === JSON.stringify(props.celulares) ||
                JSON.stringify(arr) === JSON.stringify(props.fijos) ?
                <FaPhoneAlt className="text-verde-bosque" /> :
                <FiMail className="text-verde-bosque" />;
        if (arr.length > 0) {
            jsx = <tr>
                <td className="contacto-td pb-2">
                    {icono}
                </td>
                <td className="contacto-td pb-2">
                    {arr.join(' / ')}
                </td>
            </tr>;
        }
        return jsx;
    }

    return (
        <article className="contacto-card">
            <div className="bg-verde-bosque rounded-t-xl" >
                <h2 className="contacto-card-titulo">{props.nombres}</h2>
                <h4 className="contacto-card-subtitulo">{props.cargo}</h4>
            </div>

            <table className="rounded-b-xl">
                <tbody>
                    {row(props.celulares)}
                    {row(props.fijos)}
                    {row(props.emails)}
                </tbody>
            </table>
        </article>
    )
}

export default ContactoArticle


ContactoArticle.propTypes = { celulares: PropTypes.array };
ContactoArticle.propTypes = { fijos: PropTypes.array };
ContactoArticle.propTypes = { emails: PropTypes.array };
ContactoArticle.propTypes = { nombres: PropTypes.string };
ContactoArticle.propTypes = { cargo: PropTypes.string };
