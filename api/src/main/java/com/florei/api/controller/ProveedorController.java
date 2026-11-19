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

import com.florei.api.model.Proveedor;
import com.florei.api.repo.ProveedorRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/proveedor")
@CrossOrigin
public class ProveedorController {

	@Autowired
	private ProveedorRepository proveedorRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, proveedorRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Proveedor proveedor) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			proveedor.getAuditoria().setActivo(true);
			proveedor.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, proveedorRepository.save(proveedor));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Proveedor proveedor) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			proveedor.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, proveedorRepository.save(proveedor));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			proveedorRepository.deleteById(id);
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
			Proveedor proveedor = proveedorRepository.findById(id).orElse(null);
			if (proveedor != null) {
				proveedor.getAuditoria().setActivo(!proveedor.getAuditoria().getActivo());
				proveedor.getAuditoria().setFechaModificacion(new Date());
				proveedor.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, proveedorRepository.save(proveedor));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
