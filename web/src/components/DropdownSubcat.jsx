import React from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import { sortSubcatsxNombreAsc } from '../Global';
import PropTypes from "prop-types";

function DropdownSubcat(props) {

    const [subcats, setSubCats] = React.useState([]);

    React.useEffect(() => {

        async function fetchData() {
            try {
                const response = await axios({
                    method: 'GET',
                    url: `${import.meta.env.VITE_URL_API}subcategoria`
                });

                setSubCats(response.data.resultado.filter(subcat => subcat.auditoria.activo));

            } catch (error) {
                console.error(error);
            }
        }

        fetchData();

    }, []);


    return (
        <ul className={props.abierto ? 'h-32 lg:h-72 pl-5 overflow-auto' : 'hidden'}>
            {
                subcats
                    .sort(sortSubcatsxNombreAsc)
                    .map(subcat =>
                        <li key={subcat.id} className="border-b-2 cursor-pointer">
                            <Link to={`/categorias/${subcat.slug}`}>
                                {subcat.descripcion}
                            </Link>
                        </li>
                    )
            }
        </ul>
    )
}

export default DropdownSubcat;

DropdownSubcat.propTypes = { abierto: PropTypes.bool.isRequired };
