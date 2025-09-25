import { FormEvent, useEffect, useMemo, useRef, useState } from "react";
import { cn, getApiEndpoint } from "../lib/utils";
import { type Suggestion as SuggestionType } from "../types/Suggestion";

interface ChatMessageBadge {
    label: string;
    color: string;
}

interface ChatMessageProps {
    badge?: ChatMessageBadge,
    background?: string;
    title: string;
    id?: string;
    subtitle?: string;
    content: string;
}

export const ChatMessage = ({
    badge,
    background,
    title,
    id,
    subtitle,
    content,
}: ChatMessageProps) => {
    return (
        <div className="w-full drop-shadow-xl bg-black/80 rounded-[5px] overflow-hidden p-2 gap-x-10 flex animate-message"
        style={{
            backgroundColor: background + "bf",
        }}
        >
            <div className="flex gap-x-10 h-full text-xs font-medium items-stretch text-white">
              <span>

              {badge && (
                  <span
                  className="px-1 py-1 rounded-sm break-keep text-xs uppercase text-white font-black"
                  style={{
                      color: badge.color
                    }}
                    >
                    <i className={`fa fa-${badge.label} blur-[10px] absolute top-[10px]`}></i>
                    <i className={`fa fa-${badge.label}`}></i>
                </span>
              )}
            {/* {type && ( */}
                {/* // <span className="py-[1px] opacity-50 rounded-sm text-neutral-400 break-keep text-xs uppercase text-white/50"> {type}</span> */}
            {/* // )} */}

              {subtitle && (
                  <span className="text-neutral-400"> [{subtitle}] </span>
                )}

            {title && (
                <span className="text-white font-semibold"> {title.length > 17 ? title.substring(0, 17) + "..." : title}: </span> 
            )}

            {id && (
                <span className="text-neutral-400"> ({id}): </span>
            )} 

                <span className="break-all"> {content} </span>

                </span>
            </div>
        </div>
      );
};    
    
type SuggestionProps = SuggestionType & {
    activeArg: number | null;
    onClick?: () => void;
}
    
export const Suggestion = ({
    command,
    args,
    description,
    activeArg,
    onClick
}: SuggestionProps) => {
    return (
        <button className="flex flex-col gap-0.5 bg-custom-black/75 w-full hover:opacity-80 transition p-2 rounded-[5px] animate-suggestions">
            <div className="flex items-center gap-1.5">
                <span
                    onClick={onClick}
                    className="text-xs text-left text-primary font-bold"
                    >
                    /{command}
                </span>
                {args.map((arg, key) => (
                    <span
                        key={key}
                        className={cn("text-xs text-white/75 font-medium transition", activeArg === key && "text-white")}
                    >
                        [{arg}]
                    </span>
                ))}
            </div>
            {description && (
                <p className="text-[10px] font-medium text-neutral-300">
                    {description}
                </p>
            )}
        </button>
    )
}

export const Chat = () => {
    const [isTyping, setIsTyping] = useState(true);
    const [messages, setMessages] = useState<ChatMessageProps[]>([
        {
            badge: { label: "info", color: "#3b82f6" },
            title: "System",
            content: "Witaj na serwerze!",
            background: "#000000"
        }
    ]);
    const [suggestions, setSuggestions] = useState<SuggestionType[]>([
        {
            command: "help",
            args: [],
            // description: "Pokazuje liste komend"
        }
    ]);
    const [historyIndex, setHistoryIndex] = useState(-1);
    const [history, setHistory] = useState<string[]>([]);
    const [opacity, setOpacity] = useState(1.0);
    const [isChatActive, setIsChatActive] = useState(true);
    const [offchat, setOffchat] = useState(false);

    const messagesEndRef = useRef<HTMLDivElement>(null);
    const inputRef = useRef<HTMLInputElement>(null);
    const timeoutIds = useRef<ReturnType<typeof setTimeout>[]>([]);

    useEffect(() => {
        if (isTyping) {
            inputRef.current?.focus();
        }
    }, [isTyping]);

    useEffect(() => {
        interface MessageData {
            eventName: "nui:chat:newMessage" | "nui:chat:updateSuggestions" | "nui:chat:focus" | "nui:chat:defocus" | "nui:chat:setActive" | "nui:chat:offChat";
            suggestions?: SuggestionType[];
            newMessage?: ChatMessageProps;
            isActive?: boolean;
            show?: boolean;
        }

        const onMessage = ({ data }: MessageEvent<MessageData>) => {
            if (data.eventName === "nui:chat:updateSuggestions" && data.suggestions) {
                setSuggestions(data.suggestions);
            }

            if (data.eventName === "nui:chat:setActive") {
                if (typeof data.isActive === "boolean") {
                    setIsChatActive(data.isActive);
                    if (data.isActive) {
                        setOpacity(1);
                    }
                }
            }

            if (data.eventName === "nui:chat:newMessage" && isChatActive && !offchat) {
                setMessages((prev) => {
                    if (data.newMessage) {
                        return [...prev, data.newMessage];
                    } else {
                        return [...prev];
                    }
                });
                if (messagesEndRef.current) {
                    messagesEndRef.current.scrollTop = messagesEndRef.current.scrollHeight;
                }
                setOpacity(1);
                timeoutIds.current.forEach((id) => clearTimeout(id));
                timeoutIds.current = [];
                timeoutIds.current.push(setTimeout(() => setOpacity(0), 7 * 1000));
            }

            if (data.eventName === "nui:chat:focus" && isChatActive) {
                setIsTyping(true);
                setOpacity(1);
                timeoutIds.current.forEach((id) => clearTimeout(id));
                timeoutIds.current = [];
            }

            if (data.eventName === "nui:chat:defocus" && isChatActive) {
                setIsTyping(false);
                timeoutIds.current.push(setTimeout(() => setOpacity(0), 7 * 1000));
            }

            if (data.eventName === "nui:chat:offChat") {
                if (data.show !== undefined) {
                    setOffchat(data.show);

                    if (data.show) {
                        setMessages([]);
                    }
                }
            }
        };

        window.addEventListener("message", onMessage);

        return () => window.removeEventListener("message", onMessage);
    }, [isChatActive, offchat]);
    
    useEffect(() => {
        if (messagesEndRef.current) {
            messagesEndRef.current.scrollTop = messagesEndRef.current.scrollHeight;
        }
    }, [messages]);

    useEffect(() => {
        const onKeyDown = (e: KeyboardEvent) => {
            if (!isTyping) return;
            if (e.key === 'Escape') {
                fetch(`${getApiEndpoint()}/chat/off`, { method: 'POST' });
                setIsTyping(false);
            }
            if (isTyping) {
                if (e.key === 'ArrowUp') {
                    setHistoryIndex((prevIndex) => {
                        const newIndex = Math.min(prevIndex + 1, history.length - 1);
                        const newValue = history[newIndex] || '';
                        setValue(newValue);
                        setTimeout(() => {
                            if (inputRef.current) {
                                inputRef.current.setSelectionRange(newValue.length, newValue.length);
                            }
                        }, 0);
                        return newIndex;
                    });
                } else if (e.key === 'ArrowDown') {
                    setHistoryIndex((prevIndex) => {
                        const newIndex = Math.max(prevIndex - 1, -1);
                        const newValue = history[newIndex] || '';
                        setValue(newValue);
                        setTimeout(() => {
                            if (inputRef.current) {
                                inputRef.current.setSelectionRange(newValue.length, newValue.length);
                            }
                        }, 0);
                        return newIndex;
                    });
                } else if (e.key === 'PageUp' && messagesEndRef.current) {
                    messagesEndRef.current.scrollTop -= 100;
                } else if (e.key === 'PageDown' && messagesEndRef.current) {
                    messagesEndRef.current.scrollTop += 100;
                    if (historyIndex === 10000000) return;
                }
            }
        };

        window.addEventListener("keydown", onKeyDown);

        return () => {
            window.removeEventListener("keydown", onKeyDown);
        }
    }, [isTyping, history]);

    const [value, setValue] = useState("");

    const onSend = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();

        fetch(`${getApiEndpoint()}/chat/send`, {
            method: "POST",
            body: JSON.stringify({
                message: value
            })
        })
        setHistory((prev) => [value, ...prev]);
        setHistoryIndex(-1);
        setValue("");
    }

    const filteredSuggetions = useMemo(() => {
        if (value === "") return [];

        return suggestions.filter((suggestion) => {
            const commandToStr = `/${suggestion.command}`;

            return value.toLowerCase().startsWith(commandToStr.toLowerCase()) || commandToStr.toLowerCase().startsWith(value.toLowerCase());
        }).slice(0, 5);
    }, [value, suggestions]);

    const [activeArg, setActiveArg] = useState<number | null>(null);

    const processValueToArg = () => {
        if (!inputRef.current) {
            setActiveArg((prev) => prev);
            return;
        }

        const caret = inputRef.current.selectionStart;
        
        if (!caret) {
            setActiveArg((prev) => prev);
            return;
        }

        const whereTextIAm = (value.slice(0, caret)).split(' ');

        const activeArg = whereTextIAm.length - 2;

        if (activeArg === -1) {
            setActiveArg(null);
            return;
        }

        setActiveArg(activeArg);
    }

    useEffect(() => processValueToArg(), [value, inputRef]);

    return (
        <div className={cn("w-[400px] flex flex-col gap-2 fixed left-0 top-0 m-3 transition")}>
            <div className={cn("w-full flex flex-wrap gap-2 max-h-[262.5px] overflow-y-auto no-scroll overflow-hidden transition") + (offchat ? " hidden" : "")} ref={messagesEndRef} style={{ opacity: opacity }}>
                {messages.map((message, key) => (
                    <ChatMessage
                        key={key}
                        {...message}
                    />
                ))}
            </div>
            {(isTyping) && (
                <div className="absolute top-[270px] w-full gap-2 transition">
                    <form onSubmit={onSend}>
                        <input
                            ref={inputRef}
                            value={value}
                            onChange={(e) => setValue(e.target.value)}
                            className="w-full p-2 rounded-[5px] bg-custom-black/75 font-medium placeholder:text-neutral-400 text-white text-xs outline-none y-0 transition"
                            placeholder="Czat..."
                            onKeyDown={processValueToArg}
                            onClick={processValueToArg}
                        />
                    </form>
                    {filteredSuggetions.length > 0 && (
                        <div className="w-full flex flex-col gap-1 mt-[5.5px] transition">
                            {filteredSuggetions.map((suggestion, key) => (
                                <Suggestion
                                    key={key}
                                    onClick={() => setValue(`/${suggestion}`)}
                                    activeArg={activeArg}
                                    {...suggestion}
                                />
                            ))}
                        </div>
                    )}
                </div>
            )}
        </div>
    )
}