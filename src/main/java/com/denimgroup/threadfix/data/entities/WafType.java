////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2009-2011 Denim Group, Ltd.
//
//     The contents of this file are subject to the Mozilla Public License
//     Version 1.1 (the "License"); you may not use this file except in
//     compliance with the License. You may obtain a copy of the License at
//     http://www.mozilla.org/MPL/
//
//     Software distributed under the License is distributed on an "AS IS"
//     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
//     License for the specific language governing rights and limitations
//     under the License.
//
//     The Original Code is Vulnerability Manager.
//
//     The Initial Developer of the Original Code is Denim Group, Ltd.
//     Portions created by Denim Group, Ltd. are Copyright (C)
//     Denim Group, Ltd. All Rights Reserved.
//
//     Contributor(s): Denim Group, Ltd.
//
////////////////////////////////////////////////////////////////////////
package com.denimgroup.threadfix.data.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "WafType")
public class WafType extends BaseEntity {

	private static final long serialVersionUID = 2937339816996157154L;

	public static final String MOD_SECURITY = "mod_security";
	public static final String SNORT = "Snort";
	public static final String BIG_IP_ASM = "BIG-IP ASM";
	
	@NotEmpty(message = "{errors.required}")
	@Size(max = 50, message = "{errors.maxlength}")
	private String name;
	
	private Integer initialId;

	private List<Waf> wafs;
	private List<WafRuleDirective> wafRuleDirectives;


	@Column(length = 50, nullable = false)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Column
	public Integer getInitialId() {
		if (initialId == null)
			setInitialId(100000);
		
		return initialId;
	}

	public void setInitialId(Integer initialId) {
		this.initialId = initialId;
	}

	@OneToMany(mappedBy = "wafType")
	@JsonIgnore
	public List<Waf> getWafs() {
		return wafs;
	}

	public void setWafs(List<Waf> wafs) {
		this.wafs = wafs;
	}
	
	@OneToMany(mappedBy = "wafType")
	@JsonIgnore
	public List<WafRuleDirective> getWafRuleDirectives() {
		return wafRuleDirectives;
	}

	public void setWafRuleDirectives(List<WafRuleDirective> wafRuleDirectives) {
		this.wafRuleDirectives = wafRuleDirectives;
	}
}
