////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2009-2014 Denim Group, Ltd.
//
//     The contents of this file are subject to the Mozilla Public License
//     Version 2.0 (the "License"); you may not use this file except in
//     compliance with the License. You may obtain a copy of the License at
//     http://www.mozilla.org/MPL/
//
//     Software distributed under the License is distributed on an "AS IS"
//     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
//     License for the specific language governing rights and limitations
//     under the License.
//
//     The Original Code is ThreadFix.
//
//     The Initial Developer of the Original Code is Denim Group, Ltd.
//     Portions created by Denim Group, Ltd. are Copyright (C)
//     Denim Group, Ltd. All Rights Reserved.
//
//     Contributor(s): Denim Group, Ltd.
//
////////////////////////////////////////////////////////////////////////
package com.denimgroup.threadfix.data.dao.hibernate;

import com.denimgroup.threadfix.data.dao.ScheduledScanDao;
import com.denimgroup.threadfix.data.entities.ScheduledScan;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Hibernate ScheduledScan DAO implementation. Most basic methods are implemented in
 * the AbstractGenericDao and others in ScheduledJobDao
 * 
 * @author stran
 */
@Repository
public class HibernateScheduledScanDao extends HibernateScheduledJobDao<ScheduledScan> implements ScheduledScanDao {

    public HibernateScheduledScanDao(SessionFactory sessionFactory) {
        super(sessionFactory);
    }

//    public HibernateScheduledScanDao(){}

    @Override
    protected Class<ScheduledScan> getClassReference() {
        return ScheduledScan.class;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<ScheduledScan> retrieveAll() {
        return (List<ScheduledScan>) sessionFactory.getCurrentSession().createCriteria(ScheduledScan.class)
                .add(Restrictions.eq("active", true))
                .createAlias("application", "application")
                .add(Restrictions.eq("application.active", true))
                .list();
    }
}
