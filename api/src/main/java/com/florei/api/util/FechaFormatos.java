package com.florei.api.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FechaFormatos {

	static SimpleDateFormat sdf_fecha_sin_formato = new SimpleDateFormat(Constantes.fecha_sin_formato);
	static SimpleDateFormat sdf_fecha_listado = new SimpleDateFormat(Constantes.fecha_listado);
	static SimpleDateFormat sdf_fecha_hora_sin_formato = new SimpleDateFormat(Constantes.fecha_hora_sin_formato);

	public static Date de_string_fecha_sin_formato(String param) {

		Date date = null;
		try {
			date = sdf_fecha_sin_formato.parse(param);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return date;
	}

	public static Date de_string_fecha_listado(String param) {

		Date date = null;
		try {
			date = sdf_fecha_listado.parse(param);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return date;
	}

	public static Date de_string_fecha_hora_sin_formato(String param) {

		Date date = null;
		try {
			date = sdf_fecha_hora_sin_formato.parse(param);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return date;
	}

	public static String de_date_fecha_hora_sin_formato(Date param) {

		String date = null;
		date = sdf_fecha_hora_sin_formato.format(param);
		return date;
	}

}
