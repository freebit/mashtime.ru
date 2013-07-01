# Маша учетчица

Сначала создай ключи для oauth на `github` и пропиши их в <tt>./config/omniauth.yml</tt> по примеру <tt>./config/omniauth.yml.example</tt>

# Распределение прав доступа

Для каждого проекта у пользователя устанавливается собственная проль (владелец, смотритель, участник)

<table>
<tr>
<th>Роль</th>
<th>Отмечать, смотреть и изменять свое время</th>
<th>Смотреть чужое время</th>
<th>Возможность приглашать других участников и устанавливать роли</th>
<th>Возможность добавлять, изменять и удалять чужое время</th></tr>
<tr><td>Участник</td><td>X</td><td>&middot;</td><td>&middot;</td><td>&middot;</td></tr>
<tr><td>Смотритель</td><td>X</td><td>X</td><td>&middot;</td><td>&middot;</td></tr>
<tr><td>Владелец</td><td>X</td><td>X</td><td>X</td><td>X</td></tr>
</table>

## Active admin in development

Логин: admin@example.com
Пароль: password

## Ссылочки

* [masha.brandymint.ru](http://masha.brandymint.ru/)
* [trello](https://trello.com/board/masha/51af1575c24870a46b0090c8)
* [errbit](http://errbit.brandymint.ru/apps/51b9cbd7687d9c6efa01e81b)