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

import com.florei.api.model.PrecioXGrupo;
import com.florei.api.repo.PrecioXGrupoRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/precioxgrupo")
@CrossOrigin
public class PrecioXGrupoController {
	@Autowired
	private PrecioXGrupoRepository precioXGrupoRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, precioXGrupoRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody PrecioXGrupo precioXGrupo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			precioXGrupo.getAuditoria().setActivo(true);
			precioXGrupo.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, precioXGrupoRepository.save(precioXGrupo));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody PrecioXGrupo precioXGrupo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			precioXGrupo.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, precioXGrupoRepository.save(precioXGrupo));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			precioXGrupoRepository.deleteById(id);
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
			PrecioXGrupo precioXGrupo = precioXGrupoRepository.findById(id).orElse(null);
			if (precioXGrupo != null) {
				precioXGrupo.getAuditoria().setActivo(!precioXGrupo.getAuditoria().getActivo());
				precioXGrupo.getAuditoria().setFechaModificacion(new Date());
				precioXGrupo.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, precioXGrupoRepository.save(precioXGrupo));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
