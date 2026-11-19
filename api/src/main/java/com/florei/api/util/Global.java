package com.florei.api.util;

import java.util.Map;

public class Global {

	public static String toSlug(String name) {
		return name.toLowerCase().replaceAll("\\s", "-");
	}

	public static void resultOK(Map<String, Object> result, Object obj) {

		result.put("estado", "OK");
		result.put("resultado", obj);

	}

	public static void resultError(Map<String, Object> result, Exception e) {

		result.put("estado", "Error");
		result.put("descripcion", e.toString());

	}

}
