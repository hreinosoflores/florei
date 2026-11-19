package com.florei.api.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.florei.api.model.BaseParaTubo;
import com.florei.api.repo.BaseParaTuboRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/baseparatubo")
@CrossOrigin
public class BaseParaTuboController {
	@Autowired
	private BaseParaTuboRepository baseParaTuboRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, baseParaTuboRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody BaseParaTubo baseParaTubo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			baseParaTubo.getAuditoria().setActivo(true);
			baseParaTubo.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, baseParaTuboRepository.save(baseParaTubo));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody BaseParaTubo baseParaTubo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			baseParaTubo.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, baseParaTuboRepository.save(baseParaTubo));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			baseParaTuboRepository.deleteById(id);
			Global.resultOK(result, id);
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PatchMapping("/activo/{usu}/{id}")
	public Map<String, Object> toggleActivo(@PathVariable Long usu, @PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			BaseParaTubo baseParaTubo = baseParaTuboRepository.findById(id).orElse(null);
			if (baseParaTubo != null) {
				baseParaTubo.getAuditoria().setActivo(!baseParaTubo.getAuditoria().getActivo());
				baseParaTubo.getAuditoria().setFechaModificacion(new Date());
				baseParaTubo.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, baseParaTuboRepository.save(baseParaTubo));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
